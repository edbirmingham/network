'use strict';

// Participants controller
angular.module('participants').controller('ParticipantsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Participants',
	function($scope, $stateParams, $location, Authentication, Participants) {
		$scope.authentication = Authentication;
		$scope.errorStatus = {};

		$scope.setErrors = function(errors) {
			$scope.errorStatus = {};
			if (errors.fields) {
				for (var ei in errors.fields) {
					$scope.errorStatus[errors.fields[ei]] = "has-error";
				}
			}
			$scope.errorMessages = errors.messages;
		}

		// Create new Participant
		$scope.create = function() {
			// Create new Participant object
			var participant = new Participants($scope.participant);

			// Redirect after save
			participant.$save(function(response) {
				$location.path('participants/' + response._id);

				// Clear form fields
				$scope.participant.firstName = '';
				$scope.participant.lastName = '';
				$scope.participant.phone = '';
				$scope.participant.email = '';
				$scope.participant.identity = '';
				$scope.participant.affiliation = '';
			}, function(errorResponse) {
				$scope.errors = $scope.setErrors(errorResponse.data);
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Participant
		$scope.remove = function(participant) {
			if ( participant ) { 
				participant.$remove();

				for (var i in $scope.participants) {
					if ($scope.participants [i] === participant) {
						$scope.participants.splice(i, 1);
					}
				}
			} else {
				$scope.participant.$remove(function() {
					$location.path('participants');
				});
			}
		};

		// Update existing Participant
		$scope.update = function() {
			var participant = $scope.participant;

			participant.$update(function() {
				$location.path('participants/' + participant._id);
			}, function(errorResponse) {
				$scope.errors = $scope.setErrors(errorResponse.data);
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Participants
		$scope.find = function() {
			$scope.participants = Participants.query();
		};

		// Find existing Participant
		$scope.findOne = function() {
			$scope.participant = Participants.get({ 
				participantId: $stateParams.participantId
			});
		};
		$scope.initNew = function() {
		   $scope.participant = new Participants({});
		}
	}
]);