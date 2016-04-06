'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
	Participant = mongoose.model('Participant'),
	_ = require('lodash');

/**
 * Create a Participant
 */
exports.create = function(req, res) {
	var participant = new Participant(req.body);
	participant.firstName = participant.firstName.charAt(0).toUpperCase() + participant.firstName.substr(1).toLowerCase();
	participant.lastName = participant.lastName.charAt(0).toUpperCase() + participant.lastName.substr(1).toLowerCase();
	participant.displayName = participant.firstName + ' ' + participant.lastName;
	participant.user = req.user;

	participant.save(function(err) {
		if (err) {
			return res.status(400).send(errorHandler.getErrorData(err));
		} else {
			res.jsonp(participant);
		}
	});
};

/**
 * Show the current Participant
 */
exports.read = function(req, res) {
	res.jsonp(req.participant);
};

/**
 * Update a Participant
 */
exports.update = function(req, res) {
	var participant = req.participant ;

	participant = _.extend(participant , req.body);
	participant.firstName = participant.firstName.charAt(0).toUpperCase() + participant.firstName.substr(1).toLowerCase();
	participant.lastName = participant.lastName.charAt(0).toUpperCase() + participant.lastName.substr(1).toLowerCase();
	participant.displayName = participant.firstName + ' ' + participant.lastName;

	participant.save(function(err) {
		if (err) {
			return res.status(400).send(errorHandler.getErrorData(err));
		} else {
			res.jsonp(participant);
		}
	});
};

/**
 * Delete an Participant
 */
exports.delete = function(req, res) {
	var participant = req.participant ;

	participant.remove(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(participant);
		}
	});
};

/**
 * List of Participants
 */
exports.list = function(req, res) { 
	var conditions = {};
	if (req.query.name) {
		var or_conditions = [];
		var name_parts = req.query.name.split(/[ ,]+/);
		_.each(name_parts, function(part) {
			or_conditions.push({ lastName: new RegExp('^' + part, 'i') });
			or_conditions.push({ firstName: new RegExp('^' + part, 'i') });
		});
		conditions = { $or: or_conditions };
	}
	
	var page = req.query.page || 1;
	Participant.find(conditions).count(function(err, count) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});			
		} else {
				Participant.find(conditions).skip((page-1)*10).sort('firstName lastName').populate('user', 'displayName').limit(10).exec(function(err, participants) {
				if (err) {
					return res.status(400).send({
						message: errorHandler.getErrorMessage(err)
					});	
				} else {
					res.jsonp({count: count, results: participants});
				}
			});
		}
	});
};

/**
 * Participant middleware
 */
exports.participantByID = function(req, res, next, id) { 
	Participant.findById(id).populate('user', 'displayName').exec(function(err, participant) {
		if (err) return next(err);
		if (! participant) return next(new Error('Failed to load Participant ' + id));
		req.participant = participant ;
		next();
	});
};

/**
 * Participant authorization middleware
 */
exports.hasAuthorization = function(req, res, next) {
	if (req.participant.user.id !== req.user.id) {
		return res.status(403).send('User is not authorized');
	}
	next();
};
