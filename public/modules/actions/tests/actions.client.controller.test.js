'use strict';

(function() {
	// Actions Controller Spec
	describe('Actions Controller Tests', function() {
		// Initialize global variables
		var ActionsController,
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

			// Initialize the Actions controller.
			ActionsController = $controller('ActionsController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one Action object fetched from XHR', inject(function(Actions) {
			// Create sample Action using the Actions service
			var sampleAction = new Actions({
				actor: '525a8422f6d0f87f0e407a33',
				type: 'Request',
				description: 'Action Description',
				matches: ['525a8422f6d0f87f0e407a33']
			});

			// Create a sample Actions array that includes the new Action
			var sampleActions = [sampleAction];

			// Set GET response
			$httpBackend.expectGET('network-events').respond([]);
			$httpBackend.expectGET('actions').respond(sampleActions);
			$httpBackend.expectGET('locations').respond([]);
			$httpBackend.expectGET('users').respond([]);

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.actions).toEqualData(sampleActions);
		}));

		it('$scope.findOne() should create an array with one Action object fetched from XHR using a actionId URL parameter', inject(function(Actions) {
			// Define a sample Action object
			var sampleAction = new Actions({
				name: 'New Action'
			});

			// Set the URL parameter
			$stateParams.actionId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET('network-events').respond([]);
			$httpBackend.expectGET(/actions\/([0-9a-fA-F]{24})$/).respond(sampleAction);
			$httpBackend.expectGET('users').respond([]);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.action).toEqualData(sampleAction);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Actions) {
			// Create a sample Action object
			var sampleActionPostData = new Actions({
				networkEvent: null,
				location: null,
				actor: '525a8422f6d0f87f0e407a33',
				type: 'Request',
				description: 'Action Description',
				matches: ['525a8422f6d0f87f0e407a33']
			});

			// Create a sample Action response
			var sampleActionResponse = new Actions({
				_id: '525cf20451979dea2c000001',
				actor: '525a8422f6d0f87f0e407a33',
				type: 'Request',
				description: 'Action Description',
				matches: ['525a8422f6d0f87f0e407a33']
			});

			// Fixture mock form input values
			scope.actor = {_id: '525a8422f6d0f87f0e407a33'};
			scope.action = {
				type: 'Request',
				description: 'Action Description'
			};
			scope.matches = [{_id: '525a8422f6d0f87f0e407a33'}];

			// Set POST response
			$httpBackend.expectGET('network-events').respond([]);
			$httpBackend.expectPOST('actions', sampleActionPostData).respond(sampleActionResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.actor).toEqual(null);
			expect(scope.action.type).toEqual(null);
			expect(scope.action.description).toEqual(null);
			expect(scope.matches).toEqual([]);

			// Test URL redirection after the Action was created
			expect($location.path()).toBe('/actions/create');
		}));

		it('$scope.update() should update a valid Action', inject(function(Actions) {
			// Define a sample Action put data
			var sampleActionPutData = new Actions({
				_id: '525cf20451979dea2c000001',
				description: 'New Description'
			});

			// Mock Action in scope
			scope.action = sampleActionPutData;

			// Set PUT response
			$httpBackend.expectGET('network-events').respond([]);
			$httpBackend.expectPUT(/actions\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/actions/' + sampleActionPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid actionId and remove the Action from the scope', inject(function(Actions) {
			// Create new Action object
			var sampleAction = new Actions({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new Actions array and include the Action
			scope.actions = [sampleAction];

			// Set expected DELETE response
			$httpBackend.expectGET('network-events').respond([]);
			$httpBackend.expectDELETE(/actions\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleAction);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.actions.length).toBe(0);
		}));
	});
}());