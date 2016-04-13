'use strict';

// Dashboard controller
angular.module('dashboards').controller('DashController', ['$scope', '$stateParams', '$location', 'Authentication', 'Dashboards',
	function($scope, $stateParams, $location, Authentication, Dashboards) {
		$scope.authentication = Authentication;
		var user = Authentication.user;
		$scope.currentUser = $scope.authentication.user;
		if (!$scope.authentication.user) $location.path('/signin');
		var query = {};
		
		query.userId = Authentication.user._id;
		
		// Check if current user is a Connector
		$scope.isConnector = function(user) {
			return user && user.roles.indexOf('connector') > -1;
		};
		
		// get dash info only if current user is a Connector
		if (user && user.roles.indexOf('connector') > -1) {
			var dash = Dashboards.get({
				connectorId: user._id
			});
			
			$scope.dash = dash;
			
			
			
		}
	
	}
]);