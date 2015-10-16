'use strict';

//Network events service used to communicate Network events REST endpoints
angular.module('network-events').factory('NetworkEvents', ['$resource',
	function($resource) {
		return $resource('network-events/:networkEventId', { networkEventId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);