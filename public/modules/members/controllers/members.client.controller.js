'use strict';

// Members controller
angular.module('members').controller('MembersController', ['$scope', '$stateParams', '$location', 'Authentication', 'Members', 'Participants',
	function($scope, $stateParams, $location, Authentication, Members, Participants) {
		$scope.authentication = Authentication;
		$scope.errorStatus = {};
		
		$scope.setErrors = function(errors) {
			if (errors.fields) {
				for (var ei in errors.fields) {
					$scope.errorStatus[errors.fields[ei]] = "has-error";
				}
			}
			$scope.errorMessages = errors.messages;
		}

		// Create new Member
		$scope.create = function() {
			
			var clearFields = function(Participant) {
				$scope.errorMessages = null;
				$scope.errorStatus = {};
				$scope.member.firstName = '';
				$scope.member.lastName = '';
				$scope.member.phone = '';
				$scope.member.email = '';
				$scope.member.identity = '';
				$scope.member.affiliation = '';
				$scope.member.address = '';
				$scope.member.city = '';
				$scope.member.state = '';
				$scope.member.zipCode = '';
				$scope.member.shirtSize = '';
				$scope.member.shirtReceived = '';
				$scope.member.talent = '';
				$scope.member.placeOfWorship = '';
				$scope.member.recruitment = '';
				$scope.member.communityNetworks = '';
				$scope.member.extraGroups = '';
				$scope.member.otherNetworks = '';
			};

			// Create new Member
			var member = $scope.member;
			
			if(member && member._id) {
				member.$update(function(response) {
					$location.path('members/' + response._id);
					clearFields(response);
				}, function(errorResponse) {
				    $scope.error = errorResponse.data.message;
				    $scope.errors = $scope.setErrors(errorResponse.data);

				});
				
			} else {                 
				// Redirect after save
				member.$save(function(response) {
					$location.path('members/' + response._id);
					clearFields(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				    $scope.errors = $scope.setErrors(errorResponse.data);
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
		
		$scope.showOnlyShirtlessMembers = false;
		
		$scope.shirtFilter = function(member) {
			if($scope.showOnlyShirtlessMembers === true) {
				return member.shirtReceived === false;
			} else {
				return member;
			}
		};
		
		$scope.giveShirt = function(member) {
			//var member = $scope.member;
			if(member.shirtReceived === false) {
				member.shirtReceived = true;
				
				member.$update(function() {
					
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
			}
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
		
		// Initialize a new Member
		$scope.newMember = function() {
			$scope.member = new Members({
				communityNetworks: '',
				extraGroups: '',
				otherNetworks: ''
			});
		};
		
		// A member is selected from the typehead search
		$scope.selectMember = function(participant) {
			$scope.member = new Members(participant);
			$scope.member.communityNetworks = '';
			$scope.member.extraGroups = '';
			$scope.member.otherNetworks = '';
		};
		
	
	}
]);