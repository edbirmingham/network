'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Participant = mongoose.model('Participant'),
	Action = mongoose.model('Action'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, user, action, participant;

/**
 * Action routes tests
 */
describe('Action CRUD tests', function() {
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

		// Save a user to the test db and create new Action
		user.save(function() {
			participant = new Participant({
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB',
				user: user
			});
			
			participant.save(function(){
				action = new Action({
					actor: participant,
					type: 'Request',
					description: 'Action Description',
					matches: [participant],
					user: user
				});
	
				done();
			});
		});
	});

	it('should be able to save Action instance if logged in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Action
				agent.post('/actions')
					.send(action)
					.expect(200)
					.end(function(actionSaveErr, actionSaveRes) {
						// Handle Action save error
						if (actionSaveErr) done(actionSaveErr);

						// Get a list of Actions
						agent.get('/actions')
							.end(function(actionsGetErr, actionsGetRes) {
								// Handle Action save error
								if (actionsGetErr) done(actionsGetErr);

								// Get Actions list
								var actions = actionsGetRes.body;

								// Set assertions
								(actions[0].user._id).should.equal(userId);
								(actions[0].type).should.match('Request');
								(actions[0].description).should.match('Action Description');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to save Action instance if not logged in', function(done) {
		agent.post('/actions')
			.send(action)
			.expect(401)
			.end(function(actionSaveErr, actionSaveRes) {
				// Call the assertion callback
				done(actionSaveErr);
			});
	});

	it('should not be able to save Action instance if no description is provided', function(done) {
		// Invalidate name field
		action.description = '';

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Action
				agent.post('/actions')
					.send(action)
					.expect(400)
					.end(function(actionSaveErr, actionSaveRes) {
						// Set message assertion
						(actionSaveRes.body.message).should.match('Please fill action description');
						
						// Handle Action save error
						done(actionSaveErr);
					});
			});
	});

	it('should be able to update Action instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Action
				agent.post('/actions')
					.send(action)
					.expect(200)
					.end(function(actionSaveErr, actionSaveRes) {
						// Handle Action save error
						if (actionSaveErr) done(actionSaveErr);

						// Update Action name
						action.description = 'WHY YOU GOTTA BE SO MEAN?';

						// Update existing Action
						agent.put('/actions/' + actionSaveRes.body._id)
							.send(action)
							.expect(200)
							.end(function(actionUpdateErr, actionUpdateRes) {
								// Handle Action update error
								if (actionUpdateErr) done(actionUpdateErr);

								// Set assertions
								(actionUpdateRes.body._id).should.equal(actionSaveRes.body._id);
								(actionUpdateRes.body.description).should.match('WHY YOU GOTTA BE SO MEAN?');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to get a list of Actions if not signed in', function(done) {
		// Create new Action model instance
		var actionObj = new Action(action);

		// Save the Action
		actionObj.save(function() {
			// Request Actions
			request(app).get('/actions')
				.expect(401)
				.end(function(actionSaveErr, actionSaveRes) {
					// Call the assertion callback
					done(actionSaveErr);
				});
		});
	});

	it('should be able to get a list of Actions if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Create new Action model instance
				var actionObj = new Action(action);
		
				// Save the Action
				actionObj.save(function() {
					// Request Actions
					agent.get('/actions')
						.end(function(req, res) {
							// Set assertion
							res.body.should.be.an.Array.with.lengthOf(1);
		
							// Call the assertion callback
							done();
						});
		
				});
			});
	});

	it('should not be able to get a single Action if not signed in', function(done) {
		// Create new Action model instance
		var actionObj = new Action(action);

		// Save the Action
		actionObj.save(function() {
			request(app).get('/actions/' + actionObj._id)
				.expect(401)
				.end(function(actionSaveErr, actionSaveRes) {
					// Call the assertion callback
					done(actionSaveErr);
				});
		});
	});

	it('should be able to get a single Action if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Create new Action model instance
				var actionObj = new Action(action);
		
				// Save the Action
				actionObj.save(function() {
					agent.get('/actions/' + actionObj._id)
						.end(function(req, res) {
							// Set assertion
							res.body.should.be.an.Object.with.property('description', action.description);
		
							// Call the assertion callback
							done();
						});
				});
			});
	});

	it('should be able to delete Action instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Action
				agent.post('/actions')
					.send(action)
					.expect(200)
					.end(function(actionSaveErr, actionSaveRes) {
						// Handle Action save error
						if (actionSaveErr) done(actionSaveErr);

						// Delete existing Action
						agent.delete('/actions/' + actionSaveRes.body._id)
							.send(action)
							.expect(200)
							.end(function(actionDeleteErr, actionDeleteRes) {
								// Handle Action error error
								if (actionDeleteErr) done(actionDeleteErr);

								// Set assertions
								(actionDeleteRes.body._id).should.equal(actionSaveRes.body._id);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to delete Action instance if not signed in', function(done) {
		// Set Action user 
		action.user = user;

		// Create new Action model instance
		var actionObj = new Action(action);

		// Save the Action
		actionObj.save(function() {
			// Try deleting Action
			request(app).delete('/actions/' + actionObj._id)
			.expect(401)
			.end(function(actionDeleteErr, actionDeleteRes) {
				// Set message assertion
				(actionDeleteRes.body.message).should.match('User is not logged in');

				// Handle Action error error
				done(actionDeleteErr);
			});

		});
	});

	afterEach(function(done) {
		User.remove().exec();
		Action.remove().exec();
		done();
	});
});