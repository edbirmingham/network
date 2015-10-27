'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
	Participation = mongoose.model('Participation'),
	NetworkEvent = mongoose.model('NetworkEvent'),
	_ = require('lodash');

/**
 * Create a Participation
 */
exports.create = function(req, res) {
	var participation = new Participation(req.body);
	participation.networkEvent = req.networkEvent;
	participation.user = req.user;

	participation.save(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(participation);
		}
	});
};

/**
 * List of Participations
 */
exports.list = function(req, res) { 
	Participation
		.find({networkEvent: req.networkEvent.id})
		.sort('created')
		.populate('participant', 'displayName')
		.populate('networkEvent', 'name')
		.exec(function(err, participations) {
			if (err) {
				return res.status(400).send({
					message: errorHandler.getErrorMessage(err)
				});
			} else {
				res.jsonp(participations);
			}
	});
};

/**
 * Require network event middleware
 */
exports.requiresNetworkEvent = function(req, res, next) {
	if (!req.networkEvent) {
		return res.status(401).send({
			message: 'Missing network event'
		});
	}	
	
	next();
};

/**
 * Network event middleware
 */
exports.parentNetworkEventByID = function(req, res, next, id) { 
	NetworkEvent.findById(id).populate('user', 'displayName').exec(function(err, networkEvent) {
		if (err) return next(err);
		if (! networkEvent) return next(new Error('Failed to load Event participated in ' + id));
		req.networkEvent = networkEvent ;
		next();
	});
};