'use strict';

(function() {
	// Locations Controller Spec
	describe('Locations Controller Tests', function() {
		// Initialize global variables
		var LocationsController,
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

			// Initialize the Locations controller.
			LocationsController = $controller('LocationsController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one Location object fetched from XHR', inject(function(Locations) {
			// Create sample Location using the Locations service
			var sampleLocation = new Locations({
				name: 'New Location'
			});

			// Create a sample Locations array that includes the new Location
			var sampleLocations = [sampleLocation];

			// Set GET response
			$httpBackend.expectGET('locations').respond(sampleLocations);

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.locations).toEqualData(sampleLocations);
		}));

		it('$scope.findOne() should create an array with one Location object fetched from XHR using a locationId URL parameter', inject(function(Locations) {
			// Define a sample Location object
			var sampleLocation = new Locations({
				name: 'New Location'
			});

			// Set the URL parameter
			$stateParams.locationId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET(/locations\/([0-9a-fA-F]{24})$/).respond(sampleLocation);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.location).toEqualData(sampleLocation);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Locations) {
			// Create a sample Location object
			var sampleLocationPostData = new Locations({
				name: 'New Location'
			});

			// Create a sample Location response
			var sampleLocationResponse = new Locations({
				_id: '525cf20451979dea2c000001',
				name: 'New Location'
			});

			// Fixture mock form input values
			scope.name = 'New Location';

			// Set POST response
			$httpBackend.expectPOST('locations', sampleLocationPostData).respond(sampleLocationResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.name).toEqual('');

			// Test URL redirection after the Location was created
			expect($location.path()).toBe('/locations/' + sampleLocationResponse._id);
		}));

		it('$scope.update() should update a valid Location', inject(function(Locations) {
			// Define a sample Location put data
			var sampleLocationPutData = new Locations({
				_id: '525cf20451979dea2c000001',
				name: 'New Location'
			});

			// Mock Location in scope
			scope.location = sampleLocationPutData;

			// Set PUT response
			$httpBackend.expectPUT(/locations\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/locations/' + sampleLocationPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid locationId and remove the Location from the scope', inject(function(Locations) {
			// Create new Location object
			var sampleLocation = new Locations({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new Locations array and include the Location
			scope.locations = [sampleLocation];

			// Set expected DELETE response
			$httpBackend.expectDELETE(/locations\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleLocation);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.locations.length).toBe(0);
		}));
	});
}());