'use strict';

// Participations controller
angular.module('participations').controller('ParticipationsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Participations', 'NetworkEvents', 'Participants',
	function($scope, $stateParams, $location, Authentication, Participations, NetworkEvents, Participants) {
		$scope.authentication = Authentication;
		$scope.isSelectionEditable = false;
		
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
					
					$scope.success =  $scope.attendee.firstName + ' ' + $scope.attendee.lastName + ' was successfully added.';
					$scope.isSelectionEditable = false; 
					$scope.error = null;
	
					// Clear form fields
					$scope.selected = null;
					$scope.attendee = null;
					// Focus on selecting the next actor.
					var attendee_input = document.querySelector('#participant');
					if (attendee_input) {
						attendee_input.focus();
					}
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
			};
			
			// If an attendee is selected from existing participants update the attendee
			if ($scope.attendee && $scope.attendee._id) {
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
		
		// Clears out the selected participant without saving anything.
		$scope.clearSelection = function() {
			$scope.attendee = null; 
			$scope.selected = null;
		};
		
		// Allows the selected participant to be edited and saved.
		$scope.editSelection = function() {
			$scope.isSelectionEditable = true; 
		};
		
		// Called when the attendee name in the typeahead is changed.
		$scope.onSelectedChange = function() {
			$scope.attendee = null;
			$scope.isSelectionEditable = false; 
		};
		
		// Determine if the participant form should be shown to help prevent
		// accidentally changing information for a participant.
		$scope.showForm = function(selected, isEditable) {
			return !selected || isEditable;
		};
		
		// Determine if the selected participants attributes should be shown 
		// instead of the participant form to help prevent accidental changes
		// to a participant's information.
		$scope.showSelectedAttributes = function(selected, isEditable) {
			return selected && !isEditable;
		};
	}
]);