'use strict';

(function() {
	// Members Controller Spec
	describe('Members Controller Tests', function() {
		// Initialize global variables
		var MembersController,
		scope,
		$httpBackend,
		$stateParams,
		$location;

		// The $resource service augments the response object with methods for updating and deleting the resource.
		// If we were to use the standard toEqual matcher, our tests would fail because the test values would not match
		// the responses exactly. To solve the problem, we define a new toEqualData Jasmine matcher.
		// When the toEqualData matcher compares two objects, it takes only object properties into
		// account and ignores methods.
		beforeEach(function() {
			jasmine.addMatchers({
				toEqualData: function(util, customEqualityTesters) {
					return {
						compare: function(actual, expected) {
							return {
								pass: angular.equals(actual, expected)
							};
						}
					};
				}
			});
		});

		// Then we can start by loading the main application module
		beforeEach(module(ApplicationConfiguration.applicationModuleName));

		// The injector ignores leading and trailing underscores here (i.e. _$httpBackend_).
		// This allows us to inject a service but then attach it to a variable
		// with the same name as the service.
		beforeEach(inject(function($controller, $rootScope, _$location_, _$stateParams_, _$httpBackend_) {
			// Set a new global scope
			scope = $rootScope.$new();

			// Point global variables to injected services
			$stateParams = _$stateParams_;
			$httpBackend = _$httpBackend_;
			$location = _$location_;

			// Initialize the Members controller.
			MembersController = $controller('MembersController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one Member object fetched from XHR', inject(function(Members) {
			// Create sample Member using the Members service
			var sampleMember = new Members({
				name: 'New Member'
			});

			// Create a sample Members array that includes the new Member
			var sampleMembers = [sampleMember];

			// Set GET response
			$httpBackend.expectGET('members').respond(sampleMembers);

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.members).toEqualData(sampleMembers);
		}));

		it('$scope.findOne() should create an array with one Member object fetched from XHR using a memberId URL parameter', inject(function(Members) {
			// Define a sample Member object
			var sampleMember = new Members({
				name: 'New Member'
			});

			// Set the URL parameter
			$stateParams.memberId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET(/members\/([0-9a-fA-F]{24})$/).respond(sampleMember);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.member).toEqualData(sampleMember);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Members) {
			// Create a sample Member object
			var sampleMemberPostData = new Members({
				name: 'New Member'
			});

			// Create a sample Member response
			var sampleMemberResponse = new Members({
				_id: '525cf20451979dea2c000001',
				name: 'New Member'
			});

			// Fixture mock form input values
			scope.name = 'New Member';

			// Set POST response
			$httpBackend.expectPOST('members', sampleMemberPostData).respond(sampleMemberResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.name).toEqual('');

			// Test URL redirection after the Member was created
			expect($location.path()).toBe('/members/' + sampleMemberResponse._id);
		}));

		it('$scope.update() should update a valid Member', inject(function(Members) {
			// Define a sample Member put data
			var sampleMemberPutData = new Members({
				_id: '525cf20451979dea2c000001',
				name: 'New Member'
			});

			// Mock Member in scope
			scope.member = sampleMemberPutData;

			// Set PUT response
			$httpBackend.expectPUT(/members\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/members/' + sampleMemberPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid memberId and remove the Member from the scope', inject(function(Members) {
			// Create new Member object
			var sampleMember = new Members({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new Members array and include the Member
			scope.members = [sampleMember];

			// Set expected DELETE response
			$httpBackend.expectDELETE(/members\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleMember);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.members.length).toBe(0);
		}));
	});
}());