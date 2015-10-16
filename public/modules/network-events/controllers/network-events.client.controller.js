'use strict';

// Network events controller
angular.module('network-events').controller('NetworkEventsController', ['$scope', '$stateParams', '$location', 'Authentication', 'NetworkEvents', 'Locations',
	function($scope, $stateParams, $location, Authentication, NetworkEvents, Locations) {
		$scope.authentication = Authentication;

        // Retrieve the list of possible locations for the event.
        $scope.locations = Locations.query();
        
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
	}
]);