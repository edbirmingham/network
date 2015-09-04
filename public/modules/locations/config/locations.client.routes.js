'use strict';

//Setting up route
angular.module('locations').config(['$stateProvider',
	function($stateProvider) {
		// Locations state routing
		$stateProvider.
		state('listLocations', {
			url: '/locations',
			templateUrl: 'modules/locations/views/list-locations.client.view.html'
		}).
		state('createLocation', {
			url: '/locations/create',
			templateUrl: 'modules/locations/views/create-location.client.view.html'
		}).
		state('viewLocation', {
			url: '/locations/:locationId',
			templateUrl: 'modules/locations/views/view-location.client.view.html'
		}).
		state('editLocation', {
			url: '/locations/:locationId/edit',
			templateUrl: 'modules/locations/views/edit-location.client.view.html'
		});
	}
]);
