'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
	Action = mongoose.model('Action'),
	NetworkEvent = mongoose.model('NetworkEvent'),
	_ = require('lodash');

/**
 * Create a Action
 */
exports.create = function(req, res) {
	var action = new Action(req.body);
	action.user = req.user;

	action.save(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(action);
		}
	});
};

/**
 * Show the current Action
 */
exports.read = function(req, res) {
	res.jsonp(req.action);
};

/**
 * Update a Action
 */
exports.update = function(req, res) {
	var action = req.action ;

	// This fixes a problem with assigning the network event when one
	// was not originally assigned.
	if (!action.networkevent && req.body.networkevent) {
		req.body.networkevent = req.body.networkevent._id;
	}
	if (!action.connector && req.body.connector) {
		req.body.connector = req.body.connector._id;
	}
	
	action = _.extend(action, req.body);

	action.save(function(err) {
		if (err) {
			console.log(err);
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(action);
		}
	});
};

/**
 * Delete an Action
 */
exports.delete = function(req, res) {
	var action = req.action ;

	action.remove(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(action);
		}
	});
};

/**
 * List of Actions
 */
exports.list = function(req, res) { 
	var query = {};
	if (req.query.location) {
		query.location = req.query.location;
	}
	if (req.query.connector) {
		query.connector = req.query.connector;
	}
	Action.find(query).sort('-created')
		.populate('user', 'displayName')
		.populate('networkEvent', 'name scheduled')
		.populate('actor', 'displayName')
		.populate('matches', 'displayName')
		.exec(function(err, actions) {
			if (err) {
				return res.status(400).send({
					message: errorHandler.getErrorMessage(err)
				});
			} else {
				res.jsonp(actions);
			}
		});
};

/**
 * Action middleware
 */
exports.actionByID = function(req, res, next, id) { 
	Action.findById(id)
		.populate('user', 'displayName')
		.populate('networkEvent', 'name scheduled')
		.populate('actor', 'displayName')
		.populate('matches', 'displayName')
		.populate('connector', 'displayName')
		.exec(function(err, action) {
			if (err) return next(err);
			if (! action) return next(new Error('Failed to load Action ' + id));
			req.action = action ;
			next();
		});
};
