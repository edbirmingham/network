 'use strict';

/**
 * Module dependencies.
 */
var _ = require('lodash'),
	errorHandler = require('../errors.server.controller.js'),
	mongoose = require('mongoose'),
	passport = require('passport'),
	User = mongoose.model('User');

/**
 * Update user details
 */
exports.update = function(req, res) {
	// Init Variables
	var user = req.requested_user;
	var message = null;

<<<<<<< HEAD
	// For security measurement we remove the roles from the req.body object
//	delete req.body.roles;
=======
	// If authenticated user isn't admin, disallow from
	// updating user roles
	if(req.user.roles.indexOf('admin') < 0) {
		// Set updated array to original array
		req.body.roles = user.roles;
	}
>>>>>>> make-connector

	if (user) {
		// Merge existing user
		user = _.extend(user, req.body);
		user.updated = Date.now();
		user.displayName = user.firstName + ' ' + user.lastName;
		

		user.save(function(err) {
			if (err) {
				return res.status(400).send({
					message: errorHandler.getErrorMessage(err)
				});
			} else {
				if (req.user === null) {
					req.login(user, function(err) {
						if (err) {
							res.status(400).send(err);
						} else {
							res.json(user);
						}
					});
				} else {
					res.json(user);
				}
			}
		});
	} else {
		res.status(400).send({
			message: 'User is not signed in'
		});
	}
};

/**
 * Send User
 */
exports.me = function(req, res) {
	res.json(req.user || null);
};

/**
 * Create a User
 */
exports.create = function(req, res) {
	var user = new User(req.body);
	user.user = req.user;
	user.provider = 'local';
	user.displayName = user.firstName + ' ' + user.lastName;

	user.save(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(user);
		}
	});
};

/**
 * Show the current User
 */
exports.read = function(req, res) {
	res.jsonp(req.requested_user);
};

/**
 * Delete an User
 */
exports.delete = function(req, res) {
	var user = req.requested_user ;

	user.remove(function(err) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(user);
		}
	});
};

/**
 * List of Users
 */
exports.list = function(req, res) { 
	User.find().sort('firstName lastName').populate('user', 'displayName').exec(function(err, users) {
		if (err) {
			return res.status(400).send({
				message: errorHandler.getErrorMessage(err)
			});
		} else {
			res.jsonp(users);
		}
	});
};

/**
 * User middleware
 */
exports.userByID = function(req, res, next, id) { 
	User.findById(id).populate('user', 'displayName').exec(function(err, user) {
		if (err) return next(err);
		if (! user) return next(new Error('Failed to load User ' + id));
		req.requested_user = user ;
		next();
	});
};

/**
 * User authorization middleware
 */
exports.hasAuthorization = function(req, res, next) {
	if (!req.user) {
		return res.status(403).send('User is not authorized');
	}
	next();
};

/**
 * User functionality that is disabled middleware
 */
exports.isDisabledFunctionality = function(req, res, next) {
	if (true) {
		return res.status(404).send('Page not found.');
	}
	
	next(); 
};