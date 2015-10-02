'use strict';

//Users service used to communicate Users REST endpoints
angular.module('users').factory('Users', ['$resource',
	function($resource) {
		return $resource('users/:userId', { userId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);