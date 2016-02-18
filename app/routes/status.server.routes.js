'use strict';

module.exports = function(app) {
	var status = require('../../app/controllers/status.server.controller');

    // Participants Routes
    app.route('/status')
    	.get(status.check);
};
