'use strict';

// Connector controller
angular.module('connectors').controller('ConnectorController', ['$scope', '$stateParams', '$location', 'Authentication', 'Connectors', 'Participants',
	function($scope, $stateParams, $location, Authentication,Connectors, Participants) {
		$scope.authentication = Authentication;
		var userId = Authentication.user._id;
		
		$scope.message = Connectors.getResults();
		
		$scope.registeredMembers = Connectors.getRegisteredMembers({ _id: userId});
		$scope.connectedActions = Connectors.getActions({ _id: userId});
		
	
	}
]);