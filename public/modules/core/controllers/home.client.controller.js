'use strict';


angular.module('core').controller('HomeController', ['$scope', '$location', 'Authentication', 'Users',
	function($scope, $location, Authentication, Users) {
		// This provides Authentication context.
		$scope.authentication = Authentication;
		
		// redirect to dash page, if user is present and a Connector
		if ($scope.authentication.user && 
			$scope.authentication.user.roles.indexOf('connector') > -1 ) {
				
				var path = '/dashboards/' + $scope.authentication.user._id;
				$location.path(path);
			}
		
	}
]);
