'use strict';

module.exports = function(app) {
	var users = require('../../app/controllers/users.server.controller');
	var participations = require('../../app/controllers/participations.server.controller');
	var participants = require('../../app/controllers/participants.server.controller');

    // Participants Routes
    app.route('/network-events/:parentNetworkEventId/participants')
    	.get(users.requiresLogin, participations.requiresNetworkEvent, participants.list);
    	
	// Participations Routes
	app.route('/network-events/:parentNetworkEventId/participations')
		.get(users.requiresLogin, participations.list)
		.post(users.requiresLogin, participations.create);

	// Finish by binding the Participation middleware
	app.param('parentNetworkEventId', participations.parentNetworkEventByID);
};
