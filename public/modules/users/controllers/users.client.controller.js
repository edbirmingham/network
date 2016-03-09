'use strict';

// Users controller
angular.module('users').controller('UsersController', ['$scope', '$stateParams', '$location', 'Authentication','Actions', 'Members','NetworkEvents', 'Participants', 'Participations', 'Users',
	function($scope, $stateParams, $location, Authentication, Actions, Members, NetworkEvents, Participants, Participations, Users) {
		$scope.authentication = Authentication;
		$scope.user = {};
		var currentUser = $scope.authentication.user;
		$scope.actions = Actions.query();
		$scope.members = Members.query();
		// var participations = Participations.query();
	    $scope.networkEvents = NetworkEvents.query();
	    
	    $scope.setParticipant = function(participant) {
	    	$scope.selectedPart = participant._id;
	    	$scope.user.participant = participant._id;
	    };
	    
	    
	    var getNetworkNightPercent = function() {
	    	var networkNights = $scope.networkEvents.filter( function (event) {
	    		return event.eventType === 'Raise Up Initiatives';
	    	});
	    	return $scope.networkEvents.length;
	    };
	    
	    var getCorePercent = function() {
	    	var coreMeetings = $scope.networkEvents.filter( function (event) {
	    		return event.eventType === 'Core Meeting';
	    	});
	    	return coreMeetings.length;
	    };
	    
	    var getTablePercent = function() {
	    	var connectorMeetings = $scope.networkEvents.filter( function (event) {
	    		return event.eventType === 'Connector Table Meeting';
	    	});
	    	return connectorMeetings.length;
	    };
	    
	    $scope.networkPercent = getNetworkNightPercent();
	    $scope.corePercent = getCorePercent();
	    $scope.tablePercent = getTablePercent();
	    

		$scope.memSinceMonth = function(member) {
			var newDate = new Date(member.created);
			var testDate = new Date();
			testDate.setMonth(testDate.getMonth() - 1);
			if(newDate >= testDate) {
				return member;
			}
		};
		
		$scope.memSinceYear = function(member) {
			var newDate = new Date(member.created);
			var testDate = new Date();
			testDate.setYear(testDate.getYear() - 1);
			if(newDate >= testDate) {
				return member;
			}
		};
		
		$scope.memSinceSem = function(member) {
			var newDate = new Date(member.created);
			var testDate = new Date();
			testDate.setMonth(testDate.getMonth() - 4);
			if(newDate >= testDate) {
				return member;
			}
		};
		
	
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
		
		$scope.isConnector = function(currentUser) {
			if(currentUser.roles.indexOf('connector') > -1) {
				return true;
			}
			else {
				return false;
			}
		};
		
		$scope.setConnector = function() {
			if($scope.isconnector) {
				$scope.user.roles.push('connector');
			} else {
				
				while (true) {
			  		var idx = $scope.user.roles.indexOf('connector');
			  		if (idx === -1) break;
			  		$scope.user.roles.splice(idx, 1);
				}
			}
		};

		$scope.getRegisteredMembersMonth = function() {
			
		};
		
		$scope.getRegisteredMembersSem = function() {
			
		};
		
		$scope.getRegisteredMembersYTD = function() {
			
		};

		$scope.getNoMatchesCount = function() {
			console.log(Authentication.user._id);
			return Actions.where( {status: ['Red']} ).count();
		};
		
		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};
		
		$scope.getActions = function () {
			return Actions.query();
		};

	}
]);