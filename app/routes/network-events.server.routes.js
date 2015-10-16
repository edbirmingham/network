'use strict';

module.exports = function(app) {
	var users = require('../../app/controllers/users.server.controller');
	var networkEvents = require('../../app/controllers/network-events.server.controller');

	// Network events Routes
	app.route('/network-events')
		.get(networkEvents.list)
		.post(users.requiresLogin, networkEvents.create);

	app.route('/network-events/:networkEventId')
		.get(networkEvents.read)
		.put(users.requiresLogin, networkEvents.update)
		.delete(users.requiresLogin, networkEvents.delete);

	// Finish by binding the Network event middleware
	app.param('networkEventId', networkEvents.networkEventByID);
};
