/*'use strict';

//Users service used to communicate Users REST endpoints
angular.module('connectors').factory('Connectors', ['$resource',
	function($resource) {
		return $resource('users/:userId', { userId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);*/