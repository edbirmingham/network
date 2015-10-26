'use strict';

module.exports = function(app) {
	var users = require('../../app/controllers/users.server.controller');
	var members = require('../../app/controllers/members.server.controller');

	// Members Routes
	app.route('/members')
		.get(members.list)
		.post(users.requiresLogin, members.create);

	app.route('/members/:memberId')
		.get(members.read)
		.put(users.requiresLogin, members.hasAuthorization, members.update)
		.delete(users.requiresLogin, members.hasAuthorization, members.delete);

	// Finish by binding the Member middleware
	app.param('memberId', members.memberByID);
};
