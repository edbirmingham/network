'use strict';

// Users controller
angular.module('users').controller('UsersController', ['$scope', '$stateParams', '$location', 'Authentication', 'Users',
	function($scope, $stateParams, $location, Authentication, Users) {
		$scope.authentication = Authentication;
		$scope.isadmin = null;

		// Create new User
		$scope.create = function() {
			// Create new User object
			var user = new Users ($scope.user);

			// Redirect after save
			user.$save(function(response) {
				$location.path('users/' + response._id);

				// Clear form fields
				$scope.user.firstName = '';
				$scope.user.lastName = '';
				$scope.user.displayName = '';
				$scope.user.email = '';
				$scope.user.username = '';
				$scope.user.password = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing User
		$scope.remove = function(user) {
			if ( user ) { 
				user.$remove();

				for (var i in $scope.users) {
					if ($scope.users [i] === user) {
						$scope.users.splice(i, 1);
					}
				}
			} else {
				$scope.user.$remove(function() {
					$location.path('users');
				});
			}
		};

		// Update existing User
		$scope.update = function() {
			var user = $scope.user;

			user.$update(function() {
				$location.path('users/' + user._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Users
		$scope.find = function() {
			$scope.users = Users.query();
		};

		// Find existing User
		$scope.findOne = function() {
			$scope.user = Users.get({ 
				userId: $stateParams.userId
			});
			
			$scope.checkAdmin();
		};
		
		// Add or remove the admin
		$scope.setAdmin = function() {
			if ($scope.isadmin === true) {
				$scope.user.roles.push('admin');
			} else {
				while (true) {
				  var idx = $scope.user.roles.indexOf('admin');
				  if (idx === -1) break;
				  $scope.user.roles.splice(idx, 1);
				}
			}
		};

		// Checks for admin role
		$scope.isAdmin = function() {
			var idx = $scope.user.roles.indexOf('admin');
			if (idx > -1) {
				$scope.isadmin = true;
			} else {
				$scope.isadmin = false;
			}
			
			// Gross and ugly and un-Angular but the only way to check the box.
			// Someone with a better grasp of the AngularJS event loop please fix.
			if (document.getElementById('isadmin') !== null)
				document.getElementById('isadmin').checked = $scope.isadmin;
		};
		
		// Angular/Mongoose has no way of lettng the code know when a req is done.
		// This starts checking for admin as soon as the getter is fired off.
		$scope.checkAdmin = function() {
			if (typeof($scope.user.roles) !== 'undefined')
				$scope.isAdmin();
			if ($scope.isadmin === null)
				setTimeout($scope.checkAdmin, 200);
		};
	}
]);