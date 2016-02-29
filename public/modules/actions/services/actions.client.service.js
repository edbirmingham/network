'use strict';

//Actions service used to communicate Actions REST endpoints
angular.module('actions').factory('Actions', ['$resource',
	function($resource) {
		var Action = $resource('actions/:actionId', { actionId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
		
		angular.extend(Action, {
			statuses: function() {
				return ['No match', 'Match pending', 'Match active', 'Match complete'];
			}
		});
		
		return Action;
	}
]);