'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Member = mongoose.model('Member'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, user, member;

/**
 * Member routes tests
 */
describe('Member CRUD tests', function() {
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

		// Save a user to the test db and create new Member
		user.save(function() {
			member = {
				firstName: 'Member',
				lastName: 'Name',
				displayName: 'MemberName',
				phone: '2055558888',
				email: 'mem@email.com',
				identity: 'Educator',
				affiliation: 'UAB',
				address: '1234 Broadt Street',
				city: 'Birmingham',
				state: 'AL',
				zipCode: '35204',
				shirtSize: 'XL',
				shirtReceived: true,
				talent: 'Music',
				placeOfWorship: 'Baptist Church',
				recruitment: 'Network Night',
				communityNetworks: 'Community Network',
				extraGroups: 'Group1, Group2',
				otherNetworks: 'on1, on2, on3'
			};

			done();
		});
	});

	it('should be able to save Member instance if logged in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Member
				agent.post('/members')
					.send(member)
					.expect(200)
					.end(function(memberSaveErr, memberSaveRes) {
						// Handle Member save error
						if (memberSaveErr) done(memberSaveErr);

						// Get a list of Members
						agent.get('/members')
							.end(function(membersGetErr, membersGetRes) {
								// Handle Member save error
								if (membersGetErr) done(membersGetErr);

								// Get Members list
								var members = membersGetRes.body;

								// Set assertions
								(members[0].user._id).should.equal(userId);
								(members[0].firstName).should.match('Member');
								(members[0].lastName).should.match('Name');
								(members[0].affiliation).should.match('UAB');
								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to save Member instance if not logged in', function(done) {
		agent.post('/members')
			.send(member)
			.expect(401)
			.end(function(memberSaveErr, memberSaveRes) {
				// Call the assertion callback
				done(memberSaveErr);
			});
	});

	it('should not be able to save Member instance if no name is provided', function(done) {
		// Invalidate name field
		member.firstName = '';

		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Member
				agent.post('/members')
					.send(member)
					.expect(400)
					.end(function(memberSaveErr, memberSaveRes) {
						// Set message assertion
						(memberSaveRes.body.message).should.match('Please fill in the first name');
						
						// Handle Member save error
						done(memberSaveErr);
					});
			});
	});

	it('should be able to update Member instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Member
				agent.post('/members')
					.send(member)
					.expect(200)
					.end(function(memberSaveErr, memberSaveRes) {
						// Handle Member save error
						if (memberSaveErr) done(memberSaveErr);

						// Update Member name
						member.firstName = 'WHY YOU GOTTA BE SO MEAN?';

						// Update existing Member
						agent.put('/members/' + memberSaveRes.body._id)
							.send(member)
							.expect(200)
							.end(function(memberUpdateErr, memberUpdateRes) {
								// Handle Member update error
								if (memberUpdateErr) done(memberUpdateErr);

								// Set assertions
								(memberUpdateRes.body._id).should.equal(memberSaveRes.body._id);
								(memberUpdateRes.body.firstName).should.match('WHY YOU GOTTA BE SO MEAN?');

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to get a list of Members if not signed in', function(done) {
		// Create new Member model instance
		var memberObj = new Member(member);

		// Save the Member
		memberObj.save(function() {
			// Request Members
			request(app).get('/members')
				.expect(401)
				.end(function(memberSaveError, memberSaveRes) {
					// Call the assertion callback
					done(memberSaveError);
				});

		});
	});


	it('should not be able to get a single Member if not signed in', function(done) {
		// Create new Member model instance
		var memberObj = new Member(member);

		// Save the Member
		memberObj.save(function() {
			request(app).get('/members/' + memberObj._id)
				.expect(401)
				.end(function(memberSaveError, memberSaveRes) {
					// Call the assertion callback
					done(memberSaveError);
				});
		});
	});

	it('should be able to delete Member instance if signed in', function(done) {
		agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);

				// Get the userId
				var userId = user.id;

				// Save a new Member
				agent.post('/members')
					.send(member)
					.expect(200)
					.end(function(memberSaveErr, memberSaveRes) {
						// Handle Member save error
						if (memberSaveErr) done(memberSaveErr);

						// Delete existing Member
						agent.delete('/members/' + memberSaveRes.body._id)
							.send(member)
							.expect(200)
							.end(function(memberDeleteErr, memberDeleteRes) {
								// Handle Member error error
								if (memberDeleteErr) done(memberDeleteErr);

								// Set assertions
								(memberDeleteRes.body._id).should.equal(memberSaveRes.body._id);

								// Call the assertion callback
								done();
							});
					});
			});
	});

	it('should not be able to delete Member instance if not signed in', function(done) {
		// Set Member user 
		member.user = user;

		// Create new Member model instance
		var memberObj = new Member(member);

		// Save the Member
		memberObj.save(function() {
			// Try deleting Member
			request(app).delete('/members/' + memberObj._id)
			.expect(401)
			.end(function(memberDeleteErr, memberDeleteRes) {
				// Set message assertion
				(memberDeleteRes.body.message).should.match('User is not logged in');

				// Handle Member error error
				done(memberDeleteErr);
			});

		});
	});

	afterEach(function(done) {
		User.remove().exec();
		Member.remove().exec();
		done();
	});
});