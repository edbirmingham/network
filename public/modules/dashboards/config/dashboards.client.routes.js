'use strict';

//Setting up route
angular.module('dashboards').config(['$stateProvider',
	function($stateProvider) {
		$stateProvider.
		state('viewDashboard', {
			url: '/dashboards/:connectorId',
			templateUrl: 'modules/dashboards/views/view-dashboard.client.view.html'
		});
	}
]);
