'use strict';

//Members service used to communicate Members REST endpoints
angular.module('members').factory('Members', ['$resource',
	function($resource) {
		return $resource('members/:memberId', { memberId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);