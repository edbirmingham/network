'use strict';

module.exports = function(app) {
	var users = require('../../app/controllers/users.server.controller');
	var participants = require('../../app/controllers/participants.server.controller');

	// Participants Routes
	app.route('/participants')
		.get(users.requiresLogin, participants.list)
		.post(users.requiresLogin, participants.create);

	app.route('/participants/:participantId')
		.get(users.requiresLogin, participants.read)
		.put(users.requiresLogin, participants.update)
		.delete(users.requiresLogin, participants.delete);

	// Finish by binding the Participant middleware
	app.param('participantId', participants.participantByID);
};
