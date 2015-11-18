'use strict';

(function() {
	// Network events Controller Spec
	describe('Network events Controller Tests', function() {
		// Initialize global variables
		var NetworkEventsController,
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

			// Initialize the Network events controller.
			NetworkEventsController = $controller('NetworkEventsController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one Network event object fetched from XHR', inject(function(NetworkEvents) {
			// Create sample Network event using the Network events service
			var sampleNetworkEvent = new NetworkEvents({
				name: 'Network event Name',
				eventType: 'Raise Up Network',
				location: 'locationid'
			});

			// Create a sample Network events array that includes the new Network event
			var sampleNetworkEvents = [sampleNetworkEvent];

			// Set GET response
			$httpBackend.expectGET('network-events').respond(sampleNetworkEvents);

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.networkEvents).toEqualData(sampleNetworkEvents);
		}));

		it('$scope.findOne() should create an array with one Network event object fetched from XHR using a networkEventId URL parameter', inject(function(NetworkEvents) {
			// Define a sample Network event object
			var sampleNetworkEvent = new NetworkEvents({
				name: 'New Network event'
			});

			// Set the URL parameter
			$stateParams.networkEventId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET(/network-events\/([0-9a-fA-F]{24})$/).respond(sampleNetworkEvent);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.networkEvent).toEqualData(sampleNetworkEvent);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(NetworkEvents) {
			// Create a sample Network event object
			var sampleNetworkEventPostData = new NetworkEvents({
				name: 'New Network event',
				eventType: 'Raise Up Network',
				location: '525a8422f6d0f87f0e407a33'
			});

			// Create a sample Network event response
			var sampleNetworkEventResponse = new NetworkEvents({
				_id: '525cf20451979dea2c000001',
				name: 'New Network event',
				eventType: 'Raise Up Network',
				location: '525a8422f6d0f87f0e407a33'
			});

			// Fixture mock form input values
			scope.networkEvent = {
				name: 'New Network event',
				eventType: 'Raise Up Network',
				location: {_id: '525a8422f6d0f87f0e407a33'}
			};

			// Set POST response
			$httpBackend.expectPOST('network-events', sampleNetworkEventPostData).respond(sampleNetworkEventResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.networkEvent.name).toEqual('');

			// Test URL redirection after the Network event was created
			expect($location.path()).toBe('/network-events/' + sampleNetworkEventResponse._id);
		}));

		it('$scope.update() should update a valid Network event', inject(function(NetworkEvents) {
			// Define a sample Network event put data
			var sampleNetworkEventPutData = new NetworkEvents({
				_id: '525cf20451979dea2c000001',
				name: 'New Network event'
			});

			// Mock Network event in scope
			scope.networkEvent = sampleNetworkEventPutData;

			// Set PUT response
			$httpBackend.expectPUT(/network-events\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/network-events/' + sampleNetworkEventPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid networkEventId and remove the Network event from the scope', inject(function(NetworkEvents) {
			// Create new Network event object
			var sampleNetworkEvent = new NetworkEvents({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new Network events array and include the Network event
			scope.networkEvents = [sampleNetworkEvent];

			// Set expected DELETE response
			$httpBackend.expectDELETE(/network-events\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleNetworkEvent);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.networkEvents.length).toBe(0);
		}));
	});
}());