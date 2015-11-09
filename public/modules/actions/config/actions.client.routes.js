'use strict';

//Setting up route
angular.module('actions').config(['$stateProvider',
	function($stateProvider) {
		// Actions state routing
		$stateProvider.
		state('listActions', {
			url: '/actions',
			templateUrl: 'modules/actions/views/list-actions.client.view.html'
		}).
		state('createAction', {
			url: '/actions/create',
			templateUrl: 'modules/actions/views/create-action.client.view.html'
		}).
		state('viewAction', {
			url: '/actions/:actionId',
			templateUrl: 'modules/actions/views/view-action.client.view.html'
		}).
		state('editAction', {
			url: '/actions/:actionId/edit',
			templateUrl: 'modules/actions/views/edit-action.client.view.html'
		});
	}
]);