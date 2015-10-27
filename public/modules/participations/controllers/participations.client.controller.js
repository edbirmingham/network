'use strict';

// Participations controller
angular.module('participations').controller('ParticipationsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Participations', 'NetworkEvents', 'Participants',
	function($scope, $stateParams, $location, Authentication, Participations, NetworkEvents, Participants) {
		$scope.authentication = Authentication;
		
		// Create new Participation
		$scope.create = function() {
			var saveParticipation = function(attendee) {
				// Create new Participation object
				var participation = new Participations ({
					participant: attendee._id
				});
			
				// Redirect after save
				participation.$save({ networkEventId: $stateParams.networkEventId }, function(response) {
					$location.path('network-events/' + $stateParams.networkEventId + '/participations/create');
	
					// Clear form fields
					$scope.selected = null;
					$scope.attendee.firstName = '';
					$scope.attendee.lastName = '';
					$scope.attendee.phone = '';
					$scope.attendee.email = '';
					$scope.attendee.identity = '';
					$scope.attendee.affiliation = '';
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
			};
			
			// If an attendee is selected from existing participants update the attendee
			if ($scope.attendee._id) {
				// Update the attendee participant.
				$scope.attendee.$update(function(response) {
					saveParticipation(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
				
			// Otherwise create a participant to be the attendee.
			} else {
				// Create new Participant object
				var participant = new Participants($scope.attendee);
	
				// Redirect after save
				participant.$save(function(response) {
					saveParticipation(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
				
			}
		};
		
		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};
		
		// Find existing Network event
		$scope.newParticipation = function() {
			$scope.attendee = null;
			$scope.networkEvent = NetworkEvents.get({ 
				networkEventId: $stateParams.networkEventId
			});
		};
	}
]);