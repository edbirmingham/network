'use strict';

//Locations service used to communicate Locations REST endpoints
angular.module('locations').factory('Locations', ['$resource',
	function($resource) {
		return $resource('locations/:locationId', { locationId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);