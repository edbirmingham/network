'use strict';

module.exports = function(app) {
    var users = require('../../app/controllers/users.server.controller');
	var dashboard = require('../../app/controllers/dashboards.server.controller');
	
	// GET route for connector Dashboard Information
	app.route('/connector/:connectorId')
	    .get(users.requiresLogin, dashboard.read);
	// Finish by binding the Dashboard middleware
	app.param('connectorId', dashboard.connectorByID);
};