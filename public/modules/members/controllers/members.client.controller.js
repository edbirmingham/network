'use strict';

// Members controller
angular.module('members').controller('MembersController', ['$scope', '$stateParams', '$location', 'Authentication', 'Members',
	function($scope, $stateParams, $location, Authentication, Members) {
		$scope.authentication = Authentication;

		// Create new Member
		$scope.create = function() {
			// Create new Member object
			var member = new Members($scope.member);

			// Redirect after save
			member.$save(function(response) {
				$location.path('members/' + response._id);

				// Clear form fields
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

		// Remove existing Member
		$scope.remove = function(member) {
			if ( member ) { 
				member.$remove();

				for (var i in $scope.members) {
					if ($scope.members [i] === member) {
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

		// Find existing Member
		$scope.findOne = function() {
			$scope.member = Members.get({ 
				memberId: $stateParams.memberId
			});
		};
	}
]);