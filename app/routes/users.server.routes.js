'use strict';

/**
 * Module dependencies.
 */
var passport = require('passport');

module.exports = function(app) {
	// User Routes
	var users = require('../../app/controllers/users.server.controller');
	
	// Setting up the users profile api
	app.route('/users/me').get(users.me);
	app.route('/users').put(users.update);
	app.route('/users/accounts').delete(users.removeOAuthProvider);

	// Setting up the users password api
	app.route('/users/password').post(users.changePassword);
	app.route('/auth/forgot').post(users.forgot);
	app.route('/auth/reset/:token').get(users.validateResetToken);
	app.route('/auth/reset/:token').post(users.reset);

	// Setting up the users authentication api
	app.route('/auth/signup').post(users.isDisabledFunctionality, users.signup);
	app.route('/auth/signin').post(users.signin);
	app.route('/auth/signout').get(users.signout);

	// Setting up the users CRUD
	app.route('/users')
		.get(users.requiresLogin, users.list)
		.post(users.requiresLogin, users.create);

	app.route('/users/:userId')
		.get(users.requiresLogin, users.read)
		.put(users.requiresLogin, users.hasAuthorization, users.update)
		.delete(users.requiresLogin, users.hasAuthorization, users.hasAdmin, users.delete);

	// Finish by binding the User middleware
	app.param('userId', users.userByID);
};
