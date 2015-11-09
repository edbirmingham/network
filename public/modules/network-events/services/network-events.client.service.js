'use strict';

//Network events service used to communicate Network events REST endpoints
angular.module('network-events').factory('NetworkEvents', ['$resource', '$filter',
	function($resource, $filter) {
		var NetworkEvent = $resource('network-events/:networkEventId', { networkEventId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
		
		angular.extend(NetworkEvent.prototype, {
			listName: function() {
				return this.name + ' (' + $filter('date')(this.scheduled) + ')';
			}
		});
		
		return NetworkEvent;
	}
]);