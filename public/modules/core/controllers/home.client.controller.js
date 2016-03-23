'use strict';


angular.module('core').controller('HomeController', ['$scope', 'Authentication', 'Users',
	function($scope, Authentication, Users) {
		// This provides Authentication context.
		$scope.authentication = Authentication;
		

	}
]);
