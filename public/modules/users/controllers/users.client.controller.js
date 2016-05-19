'use strict';

// Users controller
angular.module('users').controller('UsersController', ['$scope', '$filter', '$stateParams', '$location', 'Authentication','Actions', 'Members','NetworkEvents', 'Participants', 'Participations', 'Users',
	function($scope, $filter, $stateParams, $location, Authentication, Actions, Members, NetworkEvents, Participants, Participations, Users) {
		$scope.authentication = Authentication;
		$scope.user = {};
		$scope.user.roles = ['user'];
		$scope.user.participant = null;
		
	    
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
				$scope.selectedPart = null;
				$scope.user.participant = null;
				$scope.user.roles = ['user'];
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
		
		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};
		
		$scope.getActions = function () {
			return Actions.query();
		};

		// Add the selected role to the roles list.
		$scope.addRole = function(roles, role) {
			if (roles.indexOf(role) < 0) {
				roles.push(role);
			}
			
		};
		
		// Remove role from the role list.
		$scope.removeRole = function(roles, roleIndex) {
			roles.splice(roleIndex, 1);
		};
		
		var isConnector = function(user) {
			return user.roles.indexOf('connector') > -1;
		};
		
	    $scope.setParticipant = function(participant) {
	    	$scope.selectedPart = participant.listName();
	    	$scope.user.participant = participant._id;
	    };

	}
]);