'use strict';

module.exports = function(app) {
    var users = require('../../app/controllers/users.server.controller');
	var dashboards = require('../../app/controllers/dashboards.server.controller');
	
	// GET route for connector Dashboard Information
	app.route('/dashboards/:connectorId')
	    .get(users.requiresLogin, dashboards.read);
	
	// Finish by binding the Dashboard middleware
	app.param('connectorId', dashboards.connectorByID);
};