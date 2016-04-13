'use strict';

(function() {
	// Dashboards Controller Spec
	describe('Dashboards Controller Tests', function() {
		// Initialize global variables
		var DashController,
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

			// Initialize the Dashboard controller.
			DashController = $controller('DashController', {
				$scope: scope
			});
		}));

		it('$scope.get() should create an object with dashboard object fetched from XHR', inject(function(Dashboards) {
			// Create sample Dash object
			var sampleDash = {
				yearMembers: 2,
				semMembers: 1,
				monthMembers: 0,
				raisePercent: 100,
				tablePercent: 100,
				corePercent: 100
			};
			
			$stateParams.connectorId = '525cf20451979dea2c000001';


			// Set GET response
			$httpBackend.expectGET(/dashboards\/([0-9a-fA-F]{24})$/).respond(sampleDash);

			// Run controller functionality
			scope.get({connectorId: '525cf20451979dea2c000001'});
			$httpBackend.flush();

			// Test scope value
			expect(scope.dash).toEqualData(sampleDash);
			//expect($location.path()).toBe('/dashboards/' +  )
		}));

	});
}());