'use strict';

//Setting up route
angular.module('network-events').config(['$stateProvider',
	function($stateProvider) {
		// Network events state routing
		$stateProvider.
		state('listNetworkEvents', {
			url: '/network-events',
			templateUrl: 'modules/network-events/views/list-network-events.client.view.html'
		}).
		state('createNetworkEvent', {
			url: '/network-events/create',
			templateUrl: 'modules/network-events/views/create-network-event.client.view.html'
		}).
		state('viewNetworkEvent', {
			url: '/network-events/:networkEventId',
			templateUrl: 'modules/network-events/views/view-network-event.client.view.html'
		}).
		state('editNetworkEvent', {
			url: '/network-events/:networkEventId/edit',
			templateUrl: 'modules/network-events/views/edit-network-event.client.view.html'
		});
	}
]);