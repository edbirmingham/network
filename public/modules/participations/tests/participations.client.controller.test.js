'use strict';

(function() {
	// Participations Controller Spec
	describe('Participations Controller Tests', function() {
		// Initialize global variables
		var ParticipationsController,
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

			// Initialize the Participations controller.
			ParticipationsController = $controller('ParticipationsController', {
				$scope: scope
			});
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Participations) {
			// Create a sample Participation object
			var sampleParticipationPostData = new Participations({
				participant: '525a8422f6d0f87f0e407a33'
			});

			// Create a sample Participation response
			var sampleParticipationResponse = new Participations({
				_id: '525cf20451979dea2c000001',
				participant: '525cf20451979dea2c000001',
				networkEvent: '525cf20451979dea2c000001'
			});
			
			var sampleAttendeePostData = {
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			};
			
			var sampleAttendeeResponse = {
				_id: '525a8422f6d0f87f0e407a33',
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			};

			// Fixture mock form input values
			scope.networkEvent = '525cf20451979dea2c000001';
			scope.attendee = sampleAttendeePostData;

			// Set POST response
			$httpBackend.expectPOST('participants', sampleAttendeePostData).respond(sampleAttendeeResponse);
			$httpBackend.expectPOST('network-events/525a8422f6d0f87f0e407a33/participations', sampleParticipationPostData).respond(sampleParticipationResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.attendee.firstName).toEqual('');
			expect(scope.attendee.lastName).toEqual('');
			expect(scope.attendee.phone).toEqual('');
			expect(scope.attendee.email).toEqual('');
			expect(scope.attendee.identity).toEqual('');
			expect(scope.attendee.affiliation).toEqual('');

			// Test URL redirection after the Participation was created
			expect($location.path()).toBe('/network-events/525a8422f6d0f87f0e407a33/participations/create');
		}));

	});
}());