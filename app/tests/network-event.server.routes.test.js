'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Location = mongoose.model('Location'),
	NetworkEvent = mongoose.model('NetworkEvent'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, user, eventLocation, networkEvent;

/**
 * Network event routes tests
 */
describe('Network event CRUD tests', function() {
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

		// Save a user to the test db and create new Network event
		user.save(function() { 
			eventLocation = new Location({
				name: 'New Location'
			});
			
			eventLocation.save(function() {
				
				networkEvent = {
					name: 'Network event Name',
					eventType: 'Raise Up Network',
					scheduled: '10/10/2015',
					location: eventLocation.id
				};

				done();
				
			});
		});
	});

	it('should be able to save Network event instance if logged in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;
				var locationId = eventLocation.id;

				// Save a new Network event
				agent.post('/network-events')
					.send(networkEvent)
					.expect(200)
					.end(function(networkEventSaveErr, networkEventSaveRes) {
						// Handle Network event save error
						if (networkEventSaveErr) done(networkEventSaveErr);

						// Get a list of Network events
						agent.get('/network-events')
							.end(function(networkEventsGetErr, networkEventsGetRes) {
								// Handle Network event save error
								if (networkEventsGetErr) done(networkEventsGetErr);

								// Get Network events list
								var networkEvents = networkEventsGetRes.body;

								// Set assertions
								(networkEvents[0].user._id).should.equal(userId);
								(networkEvents[0].location._id).should.equal(locationId);
								(networkEvents[0].name).should.match('Network event Name');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to save Network event instance if not logged in', function(done) {
		agent.post('/network-events')
			.send(networkEvent)
			.expect(401)
			.end(function(networkEventSaveErr, networkEventSaveRes) {
				// Call the assertion callback
				done(networkEventSaveErr);
			});
	});

	it('should not be able to save Network event instance if no name is provided', function(done) {
		// Invalidate name field
		networkEvent.name = '';

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Network event
				agent.post('/network-events')
					.send(networkEvent)
					.expect(400)
					.end(function(networkEventSaveErr, networkEventSaveRes) {
						// Set message assertion
						(networkEventSaveRes.body.message).should.match('Please fill Network event name');
						
						// Handle Network event save error
						done(networkEventSaveErr);
					});
			});
	});

	it('should be able to update Network event instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Network event
				agent.post('/network-events')
					.send(networkEvent)
					.expect(200)
					.end(function(networkEventSaveErr, networkEventSaveRes) {
						// Handle Network event save error
						if (networkEventSaveErr) done(networkEventSaveErr);

						// Update Network event name
						networkEvent.name = 'WHY YOU GOTTA BE SO MEAN?';

						// Update existing Network event
						agent.put('/network-events/' + networkEventSaveRes.body._id)
							.send(networkEvent)
							.expect(200)
							.end(function(networkEventUpdateErr, networkEventUpdateRes) {
								// Handle Network event update error
								if (networkEventUpdateErr) done(networkEventUpdateErr);

								// Set assertions
								(networkEventUpdateRes.body._id).should.equal(networkEventSaveRes.body._id);
								(networkEventUpdateRes.body.name).should.match('WHY YOU GOTTA BE SO MEAN?');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should be able to get a list of Network events if not signed in', function(done) {
		// Create new Network event model instance
		var networkEventObj = new NetworkEvent(networkEvent);

		// Save the Network event
		networkEventObj.save(function() {
			// Request Network events
			request(app).get('/network-events')
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Array.with.lengthOf(1);

					// Call the assertion callback
					done();
				});

		});
	});


	it('should be able to get a single Network event if not signed in', function(done) {
		// Create new Network event model instance
		var networkEventObj = new NetworkEvent(networkEvent);

		// Save the Network event
		networkEventObj.save(function() {
			request(app).get('/network-events/' + networkEventObj._id)
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Object.with.property('name', networkEvent.name);

					// Call the assertion callback
					done();
				});
		});
	});

	it('should be able to delete Network event instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Network event
				agent.post('/network-events')
					.send(networkEvent)
					.expect(200)
					.end(function(networkEventSaveErr, networkEventSaveRes) {
						// Handle Network event save error
						if (networkEventSaveErr) done(networkEventSaveErr);

						// Delete existing Network event
						agent.delete('/network-events/' + networkEventSaveRes.body._id)
							.send(networkEvent)
							.expect(200)
							.end(function(networkEventDeleteErr, networkEventDeleteRes) {
								// Handle Network event error error
								if (networkEventDeleteErr) done(networkEventDeleteErr);

								// Set assertions
								(networkEventDeleteRes.body._id).should.equal(networkEventSaveRes.body._id);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to delete Network event instance if not signed in', function(done) {
		// Set Network event user 
		networkEvent.user = user;

		// Create new Network event model instance
		var networkEventObj = new NetworkEvent(networkEvent);

		// Save the Network event
		networkEventObj.save(function() {
			// Try deleting Network event
			request(app).delete('/network-events/' + networkEventObj._id)
			.expect(401)
			.end(function(networkEventDeleteErr, networkEventDeleteRes) {
				// Set message assertion
				(networkEventDeleteRes.body.message).should.match('User is not logged in');

				// Handle Network event error error
				done(networkEventDeleteErr);
			});

		});
	});

	afterEach(function(done) {
		User.remove().exec();
		NetworkEvent.remove().exec();
		done();
	});
});