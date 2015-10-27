'use strict';

//Setting up route
angular.module('participations').config(['$stateProvider',
	function($stateProvider) {
		// Participations state routing
		$stateProvider.
		state('createParticipation', {
			url: '/network-events/:networkEventId/participations/create',
			templateUrl: 'modules/participations/views/create-participation.client.view.html'
		});
	}
]);