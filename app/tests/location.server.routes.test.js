'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Location = mongoose.model('Location'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, user, location;

/**
 * Location routes tests
 */
describe('Location CRUD tests', function() {
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

		// Save a user to the test db and create new Location
		user.save(function() {
			location = {
				name: 'Location Name'
			};

			done();
		});
	});

	it('should be able to save Location instance if logged in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Location
				agent.post('/locations')
					.send(location)
					.expect(200)
					.end(function(locationSaveErr, locationSaveRes) {
						// Handle Location save error
						if (locationSaveErr) done(locationSaveErr);

						// Get a list of Locations
						agent.get('/locations')
							.end(function(locationsGetErr, locationsGetRes) {
								// Handle Location save error
								if (locationsGetErr) done(locationsGetErr);

								// Get Locations list
								var locations = locationsGetRes.body;

								// Set assertions
								(locations[0].user._id).should.equal(userId);
								(locations[0].name).should.match('Location Name');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to save Location instance if not logged in', function(done) {
		agent.post('/locations')
			.send(location)
			.expect(401)
			.end(function(locationSaveErr, locationSaveRes) {
				// Call the assertion callback
				done(locationSaveErr);
			});
	});

	it('should not be able to save Location instance if no name is provided', function(done) {
		// Invalidate name field
		location.name = '';

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Location
				agent.post('/locations')
					.send(location)
					.expect(400)
					.end(function(locationSaveErr, locationSaveRes) {
						// Set message assertion
						(locationSaveRes.body.message).should.match('Please fill Location name');

						// Handle Location save error
						done(locationSaveErr);
					});
			});
	});

	it('should be able to update Location instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Location
				agent.post('/locations')
					.send(location)
					.expect(200)
					.end(function(locationSaveErr, locationSaveRes) {
						// Handle Location save error
						if (locationSaveErr) done(locationSaveErr);

						// Update Location name
						location.name = 'WHY YOU GOTTA BE SO MEAN?';

						// Update existing Location
						agent.put('/locations/' + locationSaveRes.body._id)
							.send(location)
							.expect(200)
							.end(function(locationUpdateErr, locationUpdateRes) {
								// Handle Location update error
								if (locationUpdateErr) done(locationUpdateErr);

								// Set assertions
								(locationUpdateRes.body._id).should.equal(locationSaveRes.body._id);
								(locationUpdateRes.body.name).should.match('WHY YOU GOTTA BE SO MEAN?');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should be able to get a list of Locations if not signed in', function(done) {
		// Create new Location model instance
		var locationObj = new Location(location);

		// Save the Location
		locationObj.save(function() {
			// Request Locations
			request(app).get('/locations')
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Array.with.lengthOf(1);

					// Call the assertion callback
					done();
				});

		});
	});


	it('should be able to get a single Location if not signed in', function(done) {
		// Create new Location model instance
		var locationObj = new Location(location);

		// Save the Location
		locationObj.save(function() {
			request(app).get('/locations/' + locationObj._id)
				.end(function(req, res) {
					// Set assertion
					res.body.should.be.an.Object.with.property('name', location.name);

					// Call the assertion callback
					done();
				});
		});
	});

	it('should be able to delete Location instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Location
				agent.post('/locations')
					.send(location)
					.expect(200)
					.end(function(locationSaveErr, locationSaveRes) {
						// Handle Location save error
						if (locationSaveErr) done(locationSaveErr);

						// Delete existing Location
						agent.delete('/locations/' + locationSaveRes.body._id)
							.send(location)
							.expect(200)
							.end(function(locationDeleteErr, locationDeleteRes) {
								// Handle Location error error
								if (locationDeleteErr) done(locationDeleteErr);

								// Set assertions
								(locationDeleteRes.body._id).should.equal(locationSaveRes.body._id);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to delete Location instance if not signed in', function(done) {
		// Set Location user
		location.user = user;

		// Create new Location model instance
		var locationObj = new Location(location);

		// Save the Location
		locationObj.save(function() {
			// Try deleting Location
			request(app).delete('/locations/' + locationObj._id)
			.expect(401)
			.end(function(locationDeleteErr, locationDeleteRes) {
				// Set message assertion
				(locationDeleteRes.body.message).should.match('User is not logged in');

				// Handle Location error error
				done(locationDeleteErr);
			});

		});
	});

	afterEach(function(done) {
		User.remove().exec();
		Location.remove().exec();
		done();
	});
});
