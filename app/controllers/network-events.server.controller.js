'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
	NetworkEvent = mongoose.model('NetworkEvent'),
	Location = mongoose.model('Location'),
	_ = require('lodash');

/**
 * Create a Network event
 */
exports.create = function(req, res) {
	var networkEvent = new NetworkEvent(req.body);
	networkEvent.user = req.user;

	networkEvent.save(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(networkEvent);
		}
	});
};

/**
 * Show the current Network event
 */
exports.read = function(req, res) {
	res.jsonp(req.networkEvent);
};

/**
 * Update a Network event
 */
exports.update = function(req, res) {
	var networkEvent = req.networkEvent ;

	networkEvent = _.extend(networkEvent , req.body);

	networkEvent.save(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(networkEvent);
		}
	});
};

/**
 * Delete an Network event
 */
exports.delete = function(req, res) {
	var networkEvent = req.networkEvent ;

	networkEvent.remove(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(networkEvent);
		}
	});
};

/**
 * List of Network events
 */
exports.list = function(req, res) { 
	NetworkEvent
	    .find()
	    .sort('-scheduled name')
	    .populate('user', 'displayName')
	    .populate('location', 'name')
	    .exec(function(err, networkEvents) {
			if (err) {
				return res.status(400).send({
					message: errorHandler.getErrorMessage(err)
				});
			} else {
				res.jsonp(networkEvents);
			}
		});
};

/**
 * Network event middleware
 */
exports.networkEventByID = function(req, res, next, id) { 
	NetworkEvent
		.findById(id)
		.populate('user', 'displayName')
		.populate('location', 'name')
		.exec(function(err, networkEvent) {
			if (err) return next(err);
			if (! networkEvent) return next(new Error('Failed to load Network event ' + id));
			req.networkEvent = networkEvent ;
			next();
		});
};

/**
 * Network event authorization middleware
 */
exports.hasAuthorization = function(req, res, next) {
	if (req.networkEvent.user.id !== req.user.id) {
		return res.status(403).send('User is not authorized');
	}
	next();
};
