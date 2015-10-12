'use strict';

//Participants service used to communicate Participants REST endpoints
angular.module('participants').factory('Participants', ['$resource',
	function($resource) {
		return $resource('participants/:participantId', { participantId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);