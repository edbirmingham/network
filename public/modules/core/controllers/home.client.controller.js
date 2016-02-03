'use strict';


angular.module('core').controller('HomeController', ['$scope', 'Authentication', 'Actions', 'Users',
	function($scope, Authentication, Actions, Users) {
		// This provides Authentication context.
		$scope.authentication = Authentication;
		
		
	}
]);

<<<<<<< HEAD
angular.module('connector').controller('ConnController', ['$scope', 'Authentication', 'Actions', 'Members', 'Users',
	function($scope, Authentication, Actions, Members, Users) {
		// This provides Authentication context.
		$scope.authentication = Authentication;
		
		
		
>>>>>>> Added base formatting for Connector Home Page, connector methods
	}
]);
=======



>>>>>>> Added showConnectorhome to Home controller
