'use strict';

// Members controller
angular.module('members').controller('MembersController', ['$scope', '$stateParams', '$location', 'Authentication', 'Members', 'Participants',
	function($scope, $stateParams, $location, Authentication, Members, Participants) {
		$scope.authentication = Authentication;

		// Create new Member
		$scope.create = function() {
			
			var saveMember = function(Participant) {
				
				// Create new Member object
				var member = new Members($scope.member);

				// Redirect after save
				member.$save(function(response) {
					$location.path('members/' + response._id);

					// Clear form fields
					$scope.selected = null;
					$scope.member.firstName = '';
					$scope.member.lastName = '';
					$scope.member.phone = '';
					$scope.member.email = '';
					$scope.member.identity = '';
					$scope.member.affiliation = '';
					$scope.member.address = '';
					$scope.member.shirtSize = '';
					$scope.member.talent = '';
					$scope.member.placeOfWorship = '';
					$scope.member.communityNetwork1 = '';
					$scope.member.communityNetwork2 = '';
					$scope.member.communityNetwork3 = '';
					$scope.member.extraGroup1 = '';
					$scope.member.extraGroup2 = '';
					$scope.member.extraGroup3 = '';
					$scope.member.otherNetwork1 = '';
					$scope.member.otherNetwork2 = '';
					$scope.member.otherNetwork3 = '';

			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
				
			};
			
			
			if ($scope.participant._id) {
				// Update the participant to member.
				$scope.participant.$update(function(response) {
					saveMember(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
				
			// Otherwise create a new Member.
			} else {
				// Create new Participant object
				var member = new Members($scope.participant);
	
				// Redirect after save
				member.$save(function(response) {
					saveMember(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
				
			}
		};

		// Remove existing Member
		$scope.remove = function(member) {
			if ( member ) { 
				member.$remove();

				for (var i in $scope.members) {
					if ($scope .members [i] === member) {
						$scope.members.splice(i, 1);
					}
				}
			} else {
				$scope.member.$remove(function() {
					$location.path('members');
				});
			}
		};

		// Update existing Member
		$scope.update = function() {
			var member = $scope.member;

			member.$update(function() {
				$location.path('members/' + member._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Members
		$scope.find = function() {
			$scope.members = Members.query();
		};
		
		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};


		// Find existing Member
		$scope.findOne = function() {
			$scope.member = Members.get({ 
				memberId: $stateParams.memberId
			});
		};
	}
]);