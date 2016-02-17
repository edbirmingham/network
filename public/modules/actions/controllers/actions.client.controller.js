'use strict';

// Actions controller
angular.module('actions').controller('ActionsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Actions', 'Participants', 'NetworkEvents', 'Locations', 'Users',
	function($scope, $stateParams, $location, Authentication, Actions, Participants, NetworkEvents, Locations, Users) {
		$scope.authentication = Authentication;

		if (!$scope.authentication.user) $location.path('/signin');

        // Retrieve the list of possible events for the action.
        $scope.networkEvents = NetworkEvents.query();
        
		// Create new Action
		$scope.create = function() {
			$scope.action = $scope.action || {};
			
			var match_ids = [];
			angular.forEach($scope.matches, function(match){
				this.push(match._id);
			}, match_ids);
			
			var networkEventID = null;
			var locationID = null;
			if ($scope.networkEvent) {
				networkEventID = $scope.networkEvent._id;
				locationID = $scope.networkEvent.location._id;
			}
			
			var actorID = null;
			if ($scope.actor) {
				actorID = $scope.actor._id;
			}
			
			// Create new Action object
			var action = new Actions ({
				networkEvent: networkEventID,
				location: locationID,
				actor: actorID,
				type: $scope.action.type,
				description: $scope.action.description,
				matches: match_ids
			});

			// Redirect after save
			action.$save(function(response) {
				$location.path('actions/create');
				
				// Show success message
				$scope.success = $scope.actor.displayName + '\'s action was successfully added.';
				
				// Clear form fields
				$scope.actor = null;
				$scope.action.type = null;
				$scope.action.description = null;
				$scope.matches = [];
				$scope.selectedMatch = null;
				
				// Focus on selecting the next actor.
				var actor_input = document.querySelector('#actor');
				if (actor_input) {
					actor_input.focus();
				}
			}, function(errorResponse) {
				$scope.success = null;
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Action
		$scope.remove = function(action) {
			if ( action ) { 
				action.$remove();

				for (var i in $scope.actions) {
					if ($scope.actions [i] === action) {
						$scope.actions.splice(i, 1);
					}
				}
			} else {
				$scope.action.$remove(function() {
					$location.path('actions');
				});
			}
		};

		// Update existing Action
		$scope.update = function() {
			var action = $scope.action;

			action.$update(function() {
				$location.path('actions/' + action._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Actions
		$scope.find = function() {
			$scope.actions = Actions.query();
			$scope.locations = Locations.query();
			$scope.connectors = Users.query();
		};
		
		// Filter list of actions by location
		$scope.filterActions = function() {
			var query = {};
			if ($scope.location) {
				query.location = $scope.location._id;
			}
			if ($scope.connector) {
				query.connector = $scope.connector._id;
			}
			if ($scope.status){
				query.status = $scope.status;
			}
			$scope.actions = Actions.query(query);
			
		};

		// Find existing Action
		$scope.findOne = function() {
			$scope.action = Actions.get({ 
				actionId: $stateParams.actionId
			});
			$scope.connectors = Users.query();
		};
		
		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};
		
		// Initialize the create action form
		$scope.newAction = function() {
			$scope.actor = null;
			$scope.matches = [];
		};
		
		// Add the selected match to the match list.
		$scope.addMatch = function(matches, match) {
			matches.push(match);
			$scope.selectedMatch = null;
		};
		
		// Remove match from the match list.
		$scope.removeMatch = function(matches, matchIndex) {
			matches.splice(matchIndex, 1);
		};
	}
]);