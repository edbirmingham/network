'use strict';

// Network events controller
angular.module('network-events').controller('NetworkEventsController', ['$scope', '$stateParams', '$location', 'Authentication', 'NetworkEvents', 'Locations', 'Participations',
	function($scope, $stateParams, $location, Authentication, NetworkEvents, Locations, Participations) {
		$scope.authentication = Authentication;
		$scope.status = { dateOpen: false };

		$scope.open = function($event) {
		    $event.preventDefault();
		    $event.stopPropagation();
		
		    $scope.status.dateOpen = !$scope.status.dateOpen;
		  };

		// Create new Network event
		$scope.create = function() {
			// Create new Network event object
			var networkEvent = new NetworkEvents({
				name: this.networkEvent.name,
				eventType: this.networkEvent.eventType,
				location: this.networkEvent.location._id,
				scheduled: this.networkEvent.scheduled
			});

			// Redirect after save
			networkEvent.$save(function(response) {
				$location.path('network-events/' + response._id);

				// Clear form fields
				$scope.networkEvent.name = '';
				$scope.networkEvent.eventType = '';
				$scope.networkEvent.location = '';
				$scope.networkEvent.scheduled = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Network event
		$scope.remove = function(networkEvent) {
			if ( networkEvent ) { 
				networkEvent.$remove();

				for (var i in $scope.networkEvents) {
					if ($scope.networkEvents [i] === networkEvent) {
						$scope.networkEvents.splice(i, 1);
					}
				}
			} else {
				$scope.networkEvent.$remove(function() {
					$location.path('network-events');
				});
			}
		};

		$scope.removeParticipation = function(participation) {
			if (participation) {
				var $participation = new Participations(participation);
				$participation.$remove(function() {
					$scope.participations = Participations.query({
						networkEventId: $stateParams.networkEventId
					});
				});
			}
		};

		// Update existing Network event
		$scope.update = function() {
			var networkEvent = $scope.networkEvent;

			networkEvent.$update(function() {
				$location.path('network-events/' + networkEvent._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Network events
		$scope.find = function() {
			$scope.networkEvents = NetworkEvents.query();
		};

		// Find existing Network event
		$scope.findOne = function() {
			$scope.networkEvent = NetworkEvents.get({ 
				networkEventId: $stateParams.networkEventId
			});
		};
		
        // Retrieve the list of possible locations for the event.
		$scope.findLocations = function() {
	        $scope.locations = Locations.query();
		};
		
		$scope.initNew = function() {
			$scope.findLocations();
			$scope.networkEvent = new NetworkEvents({});
			$scope.networkEvent.scheduled = new Date();
			$scope.networkEvent.scheduled.setHours(19);
			$scope.networkEvent.scheduled.setMinutes(0);
			$scope.networkEvent.scheduled.setSeconds(0);
			
		};
		
		// Initialize the edit screen with the event and possible locations.
		$scope.initEdit = function() {
			$scope.findLocations();
			$scope.findOne();
		};
		
		// Initialize the view screen with the event and all the participations.
		$scope.initView = function() {
			$scope.findOne();
			$scope.participations = Participations.query({
				networkEventId: $stateParams.networkEventId
			});
		};
	}
]);