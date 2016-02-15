'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, logged_in_user, user, not_admin_user, nacreds;

/**
 * User routes tests
 */
describe('User CRUD tests', function() {
	beforeEach(function(done) {
		// Create user credentials
		credentials = {
			username: 'username',
			password: 'password'
		};
		

		// Create a new user
		logged_in_user = new User({
			firstName: 'Full',
			lastName: 'Name',
			displayName: 'Full Name',
			email: 'test@test.com',
			username: credentials.username,
			password: credentials.password,
			provider: 'local',
			roles: ['user', 'admin']
		});

		nacreds = {
			username: 'notadmin',
			password: 'password'
		};
		
		// Create a new user
		not_admin_user = new User({
			firstName: 'Notadmin',
			lastName: 'Name',
			displayName: 'Notadmin Name',
			email: 'notadmin@test.com',
			username: nacreds.username,
			password: nacreds.password,
			provider: 'local',
			roles: ['user']
		});

		// Save a user to the test db and create new User
		not_admin_user.save(function(err) {
			if (err) {
				done(err);
			}
		});

		// Save a user to the test db and create new User
		logged_in_user.save(function() {
			user = {
				firstName: 'Another',
				lastName: 'Name',
				displayName: 'Another Name',
				email: 'testname@test.com',
				username: 'testusername',
				password: 'testpassword',
				provider: 'local',
				roles: ['user']
			};

			done();
		});
	});

	it('should be able to save User instance if logged in as admin', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = logged_in_user.id;

				// Save a new User
				agent.post('/users')
					.send(user)
					.expect(200)
					.end(function(userSaveErr, userSaveRes) {
						// Handle User save error
						if (userSaveErr) done(userSaveErr);

						// Get a list of Users
						agent.get('/users')
							.end(function(usersGetErr, usersGetRes) {
								// Handle User save error
								if (usersGetErr) done(usersGetErr);

								// Get Users list
								var users = usersGetRes.body;

								// Set assertions
								(users[0].user._id).should.equal(userId);
								(users[0].displayName).should.match('Another Name');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	// NEW TEST 02/12/2016
	it('nyan nyan nyan', function(done) {


		agent.post('/auth/signin')
			.send(nacreds)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if(signinErr) done(signinErr);
				
				var userId = not_admin_user.id;
				
				// Save a new User
				agent.post('/users')
					.send(user)
					.expect(403)
					.end(function(userSaveErr, userSaveRes) {
						// Handle User save error
						done(userSaveErr);
					});				
			});
	});


	it('should not be able to save User instance if not logged in', function(done) {
		agent.post('/users')
			.send(user)
			.expect(401)
			.end(function(userSaveErr, userSaveRes) {
				// Call the assertion callback
				done(userSaveErr);
			});
	});

	it('should not be able to save User instance if no name is provided', function(done) {
		// Invalidate name field
		user.firstName = '';

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = logged_in_user.id;

				// Save a new User
				agent.post('/users')
					.send(user)
					.expect(400)
					.end(function(userSaveErr, userSaveRes) {
						// Set message assertion
						(userSaveRes.body.message).should.match('Please fill in your first name');
						
						// Handle User save error
						done(userSaveErr);
					});
			});
	});

	it('should be able to update User instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = logged_in_user.id;

				// Save a new User
				agent.post('/users')
					.send(user)
					.expect(200)
					.end(function(userSaveErr, userSaveRes) {
						// Handle User save error
						if (userSaveErr) done(userSaveErr);

						// Update User name
						user.firstName = 'WHY YOU GOTTA BE SO MEAN?';

						// Update existing User
						agent.put('/users/' + userSaveRes.body._id)
							.send(user)
							.expect(200)
							.end(function(userUpdateErr, userUpdateRes) {
								// Handle User update error
								if (userUpdateErr) done(userUpdateErr);

								// Set assertions
								(userUpdateRes.body._id).should.equal(userSaveRes.body._id);
								(userUpdateRes.body.firstName).should.match('WHY YOU GOTTA BE SO MEAN?');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to get a list of Users if not signed in', function(done) {
		// Create new User model instance
		var userObj = new User(user);

		// Save the User
		userObj.save(function() {
			// Request Users
			request(app).get('/users')
				.expect(401)
				.end(function(userSaveErr, userSaveRes) {
					// Call the assertion callback
					done(userSaveErr);
				});

		});
	});


	it('should not be able to get a single User if not signed in', function(done) {
		// Create new User model instance
		var userObj = new User(user);

		// Save the User
		userObj.save(function() {
			request(app).get('/users/' + userObj._id)
				.expect(401)
				.end(function(userSaveErr, userSaveRes) {
					// Call the assertion callback
					done(userSaveErr);
				});
		});
	});

	it('should be able to delete User instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = logged_in_user.id;

				// Save a new User
				agent.post('/users')
					.send(user)
					.expect(200)
					.end(function(userSaveErr, userSaveRes) {
						// Handle User save error
						if (userSaveErr) done(userSaveErr);

						// Delete existing User
						agent.delete('/users/' + userSaveRes.body._id)
							.send(user)
							.expect(200)
							.end(function(userDeleteErr, userDeleteRes) {
								// Handle User error error
								if (userDeleteErr) done(userDeleteErr);

								// Set assertions
								(userDeleteRes.body._id).should.equal(userSaveRes.body._id);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to delete User instance if not signed in', function(done) {
		// Set User user 
		user.user = logged_in_user;

		// Create new User model instance
		var userObj = new User(user);

		// Save the User
		userObj.save(function() {
			// Try deleting User
			request(app).delete('/users/' + userObj._id)
			.expect(401)
			.end(function(userDeleteErr, userDeleteRes) {
				// Set message assertion
				(userDeleteRes.body.message).should.match('User is not logged in');

				// Handle User error error
				done(userDeleteErr);
			});

		});
	});

	afterEach(function(done) {
		User.remove().exec();
		User.remove().exec();
		done();
	});
});