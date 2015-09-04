'use strict';

module.exports = function(app) {
	var users = require('../../app/controllers/users.server.controller');
	var locations = require('../../app/controllers/locations.server.controller');

	// Locations Routes
	app.route('/locations')
		.get(users.requiresLogin, locations.list)
		.post(users.requiresLogin, locations.create);

	app.route('/locations/:locationId')
		.get(users.requiresLogin, locations.read)
		.put(users.requiresLogin, locations.hasAuthorization, locations.update)
		.delete(users.requiresLogin, locations.hasAuthorization, locations.delete);

	// Finish by binding the Location middleware
	app.param('locationId', locations.locationByID);
};
