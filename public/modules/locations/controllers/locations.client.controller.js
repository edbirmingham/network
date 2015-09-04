'use strict';

// Locations controller
angular.module('locations').controller('LocationsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Locations',
	function($scope, $stateParams, $location, Authentication, Locations) {
		$scope.authentication = Authentication;

		// Create new Location
		$scope.create = function() {
			// Create new Location object
			var location = new Locations ({
				name: this.name
			});

			// Redirect after save
			location.$save(function(response) {
				$location.path('locations/' + response._id);

				// Clear form fields
				$scope.name = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Location
		$scope.remove = function(location) {
			if ( location ) { 
				location.$remove();

				for (var i in $scope.locations) {
					if ($scope.locations [i] === location) {
						$scope.locations.splice(i, 1);
					}
				}
			} else {
				$scope.location.$remove(function() {
					$location.path('locations');
				});
			}
		};

		// Update existing Location
		$scope.update = function() {
			var location = $scope.location;

			location.$update(function() {
				$location.path('locations/' + location._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Locations
		$scope.find = function() {
			$scope.locations = Locations.query();
		};

		// Find existing Location
		$scope.findOne = function() {
			$scope.location = Locations.get({ 
				locationId: $stateParams.locationId
			});
		};
	}
]);