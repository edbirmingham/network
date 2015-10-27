'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Location = mongoose.model('Location'),
	NetworkEvent = mongoose.model('NetworkEvent'),
	Participant = mongoose.model('Participant'),
	Participation = mongoose.model('Participation'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, user, networkEvent, participant, participation;

/**
 * Participation routes tests
 */
describe('Participation CRUD tests', function() {
	beforeEach(function(done) {
		// Create user credentials
		credentials = {
			username: 'username',
			password: 'password'
		};

		// Create a new user
		user = new User({
			firstName: 'Full',
			lastName: 'Name',
			displayName: 'Full Name',
			email: 'test@test.com',
			username: credentials.username,
			password: credentials.password,
			provider: 'local'
		});

		// Save a user to the test db and create new Participation
		user.save(function() {
			done();
		});
	});

	beforeEach(function(done) {
		var eventLocation = new Location({
			name: 'New Location'
		});
		
		eventLocation.save(function() {
			
			networkEvent = new NetworkEvent({
				name: 'Network event Name',
				eventType: 'Raise Up Network',
				scheduled: '10/10/2015',
				location: eventLocation.id
			});
			
			networkEvent.save(function(){
				done();
			});
		});
	});
	
	beforeEach(function(done) {
		participant = new Participant({
			firstName: 'Par',
			lastName: 'Ticipant',
			displayName: 'Par Ticipant',
			phone: '2059999999',
			email: 'participant@example.com',
			identity: 'Student',
			affiliation: 'UAB'
		});
		
		participant.save(function(){
			participation = {
				participant: participant.id
			};

			done();
		});
	});
	
	it('should be able to save Participation instance if logged in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				var participantId = participant.id;
				var networkEventId = networkEvent.id;

				// Save a new Participation
				agent.post('/network-events/' + networkEventId + '/participations')
					.send(participation)
					.expect(200)
					.end(function(participationSaveErr, participationSaveRes) {
						// Handle Participation save error
						if (participationSaveErr) done(participationSaveErr);

						// Get a list of Participations
						agent.get('/network-events/' + networkEventId + '/participations')
							.end(function(participationsGetErr, participationsGetRes) {
								// Handle Participation save error
								if (participationsGetErr) done(participationsGetErr);

								// Get Participations list
								var participations = participationsGetRes.body;

								// Set assertions
								(participations[0].participant._id).should.equal(participantId);
								(participations[0].networkEvent._id).should.equal(networkEventId);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should be able to save Participation instance if not logged in', function(done) {
		// Save a new Participation
		agent.post('/network-events/' + networkEvent.id + '/participations')
			.send(participation)
			.expect(200)
			.end(function(participationSaveErr, participationSaveRes) {
				// Handle Participation save error
				if (participationSaveErr) done(participationSaveErr);

				var participantId = participant.id;
				var networkEventId = networkEvent.id;
				
				Participation
					.find({networkEvent: networkEventId})
					.populate('participant', 'displayName')
					.populate('networkEvent', 'name')
					.exec(function(err, participations){
						// Set assertions
						(participations[0].participant._id.toString()).should.equal(participantId);
						(participations[0].networkEvent._id.toString()).should.equal(networkEventId);

						// Call the assertion callback
						done();
					});
			});
	});

	it('should not be able to save Participation instance if no participant is provided', function(done) {
		// Invalidate name field
		participation.participant = null;

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Participation
				agent.post('/network-events/' + networkEvent.id + '/participations')
					.send(participation)
					.expect(400)
					.end(function(participationSaveErr, participationSaveRes) {
						// Set message assertion
						(participationSaveRes.body.message).should.match('Please specify a Participant');
						
						// Handle Participation save error
						done(participationSaveErr);
					});
			});
	});

	it('should not be able to get a list of Participations if not signed in', function(done) {
		// Create new Participation model instance
		var participationObj = new Participation(participation);

		// Save the Participation
		participationObj.save(function() {
			// Request Participations
			request(app)
				.get('/network-events/' + networkEvent.id + '/participations')
				.expect(401)
				.end(function(participantListErr, participantListRes) {
					// Call the assertion callback
					done(participantListErr);
				});
		});
	});

	afterEach(function(done) {
		User.remove().exec();
		Participation.remove().exec();
		Participant.remove().exec();
		NetworkEvent.remove().exec();
		done();
	});
});