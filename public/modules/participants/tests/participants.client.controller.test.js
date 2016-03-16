'use strict';

(function() {
	// Participants Controller Spec
	describe('Participants Controller Tests', function() {
		// Initialize global variables
		var ParticipantsController,
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

			// Initialize the Participants controller.
			ParticipantsController = $controller('ParticipantsController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one Participant object fetched from XHR', inject(function(Participants) {
			// Create sample Participant using the Participants service
			var sampleParticipant = new Participants({
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			});

			// Create a sample Participants array that includes the new Participant
			var sampleParticipants = [sampleParticipant];

			// Set GET response
			$httpBackend.expectGET('participants?page=1').respond({count: 1, results: sampleParticipants});

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.participants).toEqualData(sampleParticipants);
		}));

		it('$scope.findOne() should create an array with one Participant object fetched from XHR using a participantId URL parameter', inject(function(Participants) {
			// Define a sample Participant object
			var sampleParticipant = new Participants({
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			});

			// Set the URL parameter
			$stateParams.participantId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET(/participants\/([0-9a-fA-F]{24})$/).respond(sampleParticipant);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.participant).toEqualData(sampleParticipant);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Participants) {
			// Create a sample Participant object
			var sampleParticipantPostData = new Participants({
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			});

			// Create a sample Participant response
			var sampleParticipantResponse = new Participants({
				_id: '525cf20451979dea2c000001',
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			});

			// Fixture mock form input values
			scope.participant = sampleParticipantPostData;

			// Set POST response
			$httpBackend.expectPOST('participants', sampleParticipantPostData).respond(sampleParticipantResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.participant.firstName).toEqual('');

			// Test URL redirection after the Participant was created
			expect($location.path()).toBe('/participants/' + sampleParticipantResponse._id);
		}));

		it('$scope.update() should update a valid Participant', inject(function(Participants) {
			// Define a sample Participant put data
			var sampleParticipantPutData = new Participants({
				_id: '525cf20451979dea2c000001',
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			});

			// Mock Participant in scope
			scope.participant = sampleParticipantPutData;

			// Set PUT response
			$httpBackend.expectPUT(/participants\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/participants/' + sampleParticipantPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid participantId and remove the Participant from the scope', inject(function(Participants) {
			// Create new Participant object
			var sampleParticipant = new Participants({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new Participants array and include the Participant
			scope.participants = [sampleParticipant];

			// Set expected DELETE response
			$httpBackend.expectDELETE(/participants\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleParticipant);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.participants.length).toBe(0);
		}));
	});
}());