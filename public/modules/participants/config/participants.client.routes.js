'use strict';

//Setting up route
angular.module('participants').config(['$stateProvider',
	function($stateProvider) {
		// Participants state routing
		$stateProvider.
		state('listParticipants', {
			url: '/participants',
			templateUrl: 'modules/participants/views/list-participants.client.view.html'
		}).
		state('createParticipant', {
			url: '/participants/create',
			templateUrl: 'modules/participants/views/create-participant.client.view.html'
		}).
		state('viewParticipant', {
			url: '/participants/:participantId',
			templateUrl: 'modules/participants/views/view-participant.client.view.html'
		}).
		state('editParticipant', {
			url: '/participants/:participantId/edit',
			templateUrl: 'modules/participants/views/edit-participant.client.view.html'
		});
	}
]);