'use strict';


angular.module('core').controller('HomeController', ['$scope', 'Authentication', 'Actions', 'Users',
	function($scope, Authentication, Actions, Users) {
		// This provides Authentication context.
		$scope.authentication = Authentication;
<<<<<<< HEAD

		$scope.currentUser = $scope.authentication.user;
		
		$scope.showConnectorHome = false;
=======
>>>>>>> Make Dashboard only visible to Connectors
		
	}
]);


