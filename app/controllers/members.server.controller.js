'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
	Member = mongoose.model('Member'),
	_ = require('lodash'),
	Participant = mongoose.model('Participant');
/**
 * Create a Member
 */
exports.create = function(req, res) {
	var member = new Member(req.body);
	member.displayName = member.firstName + ' ' + member.lastName;
	member.user = req.user;
	

	member.save(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(member);
		}
	});
};


/**
 * Show the current Member
 */
exports.read = function(req, res) {
	res.jsonp(req.member);
};

/**
 * Update a Member
 */
exports.update = function(req, res) {
	if(req.participant) {
		req.member.validate( function (err){
			if (err) {
				return res.status(400).send({
					message: errorHandler.getErrorMessage(err)
				});
  			}	else {
  				
  				//	delete req.participant
  				req.participant.remove( function (err) {
  					if(err) {
  						return res.status(400).send({
  							message: errorHandler.getErrorMessage(err)
  						})
  					} else {
  						res.jsonp(req.participant);
  					}	
  				});
  			
            	//	save req.member
        		member.save(function(err) {
					if (err) {
						return res.status(400).send({
							message: errorHandler.getErrorMessage(err)
						});
					} else {
						res.jsonp(member);
					}
				});
				
  			}
		});
	}
	else {
		//save member
		var member = req.member;
		member = _.extend(member, req.body);
		member.displayName = member.firstName + ' ' + member.lastName;
		member.save(function(err) {
			if (err) {
				return res.status(400).send({
					message: errorHandler.getErrorMessage(err)
				});	
			} else {
				res.jsonp(member);
			}
		});
		
	}
	
};

/**
 * Delete an Member
 */
exports.delete = function(req, res) {
	var member = req.member ;

	member.remove(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(member);
		}
	});
};

/**
 * List of Members
 */
exports.list = function(req, res) { 
	Member.find().sort('firstName lastName').populate('user', 'displayName').exec(function(err, members) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(members);
		}
	});
};

/**
 * Member middleware
 */
exports.memberByID = function(req, res, next, id) { 
	Member.findById(id).populate('user', 'displayName').exec(function(err, member) {
		if (err) return next(err);
		// if no member is found
		if( member) {
			req.member = member;
		}
		else {
			//use Participant model to search for participant
			Participant.findById(id).populate('user', 'displayName').cast(Member, res).exec(function(err, participant) {
				if(err) return next(err);
				//cast participant as Member
				if (participant) {
					req.participant = participant;
					req.member = new Member(participant);
				}
			});
		}
		req.member = member ;
		next();
	});
};

/**
 * Member authorization middleware
 */
exports.hasAuthorization = function(req, res, next) {
	if (req.member.user.id !== req.user.id) {
		return res.status(403).send('User is not authorized');
	}
	next();
};
