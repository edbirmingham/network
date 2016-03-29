'use strict';

// Dashboard controller
angular.module('dashboard').controller('DashController', ['$scope', '$stateParams', '$location', 'Authentication', 'Dashboards', 'Participants',
	function($scope, $stateParams, $location, Authentication, Dashboards, Participants) {
		$scope.authentication = Authentication;
		var currentUser = $scope.authentication.user;
		var query = {};
		query.userId = Authentication.user._id;
		
		// Check if current user is a Connector
		$scope.isConnector = function(user) {
			return user.roles.indexOf('connector') > -1;
		};
		
		// get dash info only if current user is a Connector
	//	if (currentUser.indexOf('connector') > -1) {
			$scope.dash = Dashboards.read(query);
	//	}
		
		
			
		
		
		
	
	}
]);