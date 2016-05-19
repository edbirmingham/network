'use strict';

//Dashboard  service used to communicate Dashboard REST endpoints
angular.module('dashboards').factory('Dashboards', ['$resource',
	function($resource) {
		return $resource('dashboards/:connectorId', { connectorId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);