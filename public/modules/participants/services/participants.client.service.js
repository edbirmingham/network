'use strict';

//Participants service used to communicate Participants REST endpoints
angular.module('participants').factory('Participants', ['$resource',
	function($resource) {
		var Participant = $resource('participants/:participantId', { participantId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
		
		angular.extend(Participant.prototype, {
			listName: function() {
				return this.displayName + ' (' + this.phone + ')';
			}
		});
		
		return Participant;
	}
]);