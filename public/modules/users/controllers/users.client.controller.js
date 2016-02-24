'use strict';

// Users controller
angular.module('users').controller('UsersController', ['$scope', '$stateParams', '$location', 'Authentication', 'Users',
	function($scope, $stateParams, $location, Authentication, Users) {
		$scope.authentication = Authentication;
		$scope.user = {};
		$scope.roles = ['user'];
		// Create new User
		$scope.create = function() {
			// Create new User object
			var user = new Users ($scope.user);
			$scope.user.roles = [];
			for(var i = 0; i < $scope.roles.length; i++) {
				$scope.user.roles = $scope.user.roles.push($scope.roles[i]);
			}
			
			
			//angular.forEach($scope.user.roles, function(role){
			//	this.push(role);
		//}, $scope.roles);
			
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
				$scope.user.roles = [];
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
		};
		
			// Add the selected role to the roles list.
		$scope.addRole = function(roles, role) {
			roles.push(role);
		};
		
		// Remove role from the role list.
		$scope.removeRole = function(roles, roleIndex) {
			roles.splice(roleIndex, 1);
		};
	}
]);