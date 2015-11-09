'use strict';

module.exports = function(app) {
	var users = require('../../app/controllers/users.server.controller');
	var actions = require('../../app/controllers/actions.server.controller');

	// Actions Routes
	app.route('/actions')
		.get(users.requiresLogin, actions.list)
		.post(users.requiresLogin, actions.create);

	app.route('/actions/:actionId')
		.get(users.requiresLogin, actions.read)
		.put(users.requiresLogin, actions.update)
		.delete(users.requiresLogin, actions.delete);

	// Finish by binding the Action middleware
	app.param('actionId', actions.actionByID);
};
