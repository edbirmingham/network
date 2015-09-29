'use strict';

(function() {
	// Users Controller Spec
	describe('Users Controller Tests', function() {
		// Initialize global variables
		var UsersController,
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

			// Initialize the Users controller.
			UsersController = $controller('UsersController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one User object fetched from XHR', inject(function(Users) {
			// Create sample User using the Users service
			var sampleUser = new Users({
				name: 'New User'
			});

			// Create a sample Users array that includes the new User
			var sampleUsers = [sampleUser];

			// Set GET response
			$httpBackend.expectGET('users').respond(sampleUsers);

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.users).toEqualData(sampleUsers);
		}));

		it('$scope.findOne() should create an array with one User object fetched from XHR using a userId URL parameter', inject(function(Users) {
			// Define a sample User object
			var sampleUser = new Users({
				name: 'New User'
			});

			// Set the URL parameter
			$stateParams.userId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET(/users\/([0-9a-fA-F]{24})$/).respond(sampleUser);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.user).toEqualData(sampleUser);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Users) {
			// Create a sample User object
			var sampleUserPostData = new Users({
				firstName: 'Test',
				lastName: 'Name',
				displayName: 'Test Name',
				email: 'testname@test.com',
				username: 'testusername',
				password: 'testpassword',
				provider: 'local'
			});

			// Create a sample User response
			var sampleUserResponse = new Users({
				_id: '525cf20451979dea2c000001',
				firstName: 'Test',
				lastName: 'Name',
				displayName: 'Test Name',
				email: 'testname@test.com',
				username: 'testusername',
				provider: 'local'
			});

			// Fixture mock form input values
			scope.user = sampleUserPostData;
			
			// Set POST response
			$httpBackend.expectPOST('users', sampleUserPostData).respond(sampleUserResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.user.firstName).toEqual('');

			// Test URL redirection after the User was created
			expect($location.path()).toBe('/users/' + sampleUserResponse._id);
		}));

		it('$scope.update() should update a valid User', inject(function(Users) {
			// Define a sample User put data
			var sampleUserPutData = new Users({
				_id: '525cf20451979dea2c000001',
				name: 'New User'
			});

			// Mock User in scope
			scope.user = sampleUserPutData;

			// Set PUT response
			$httpBackend.expectPUT(/users\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/users/' + sampleUserPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid userId and remove the User from the scope', inject(function(Users) {
			// Create new User object
			var sampleUser = new Users({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new Users array and include the User
			scope.users = [sampleUser];

			// Set expected DELETE response
			$httpBackend.expectDELETE(/users\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleUser);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.users.length).toBe(0);
		}));
	});
}());