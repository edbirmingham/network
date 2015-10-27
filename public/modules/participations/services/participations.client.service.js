'use strict';

//Participations service used to communicate Participations REST endpoints
angular.module('participations').factory('Participations', ['$resource',
	function($resource) {
		return $resource('network-events/:networkEventId/participations/:participationId', { participationId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);