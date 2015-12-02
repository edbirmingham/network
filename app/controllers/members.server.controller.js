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
	var member = req.member;
	
	member = _.extend(member , req.body);
	member.displayName = member.firstName + ' ' + member.lastName;
	
	// If the Member is being converted from a Participant.
	if (member.isNew) {
		member.validate(function(err) {    
  			if(err) {
  				return res.status(400).send({
  					message: errorHandler.getErrorMessage(err)
  				}); 
  			} else {
  				Participant.update({_id: member._id}, {$set: {__t: 'Member'}}, {strict: false}, function (err) {
  					if (err) {
 						return res.status(400).send({
 							message: errorHandler.getErrorMessage(err)
 						});
  					} else {
  						Member.update({_id: member._id }, { $set: member}, function(err){  //goodjj
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
		});
	// If the Member already exists and is being updated.
	} else {
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
		if( member) {
			req.member = member;
			next();
		} else {
			//use Participant model to search for participant
			Participant.findById(id).populate('user', 'displayName').exec(function(err, participant) {
				if(err) return next(err);
				if (!participant) return next(new Error('Failed to load Member ' + id));
				
				// Cast participant as member	
				req.member = new Member(participant);
				next();
			});
		}
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
