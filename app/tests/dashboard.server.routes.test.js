/*'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	Participant = require('Participant');
	User = mongoose.model('User'),
	agent = request.agent(app);

/**
 * Globals
 *//*
var credentials, logged_in_user, user, participant;

describe('Connector Dashboard tests', function() {
    
    beforeEach(function(done) {
        participant = new Participant({
            firstName: 'Test',
            lastName: 'Participant',
            phone:'2223334444',
            identity: 'participant',
            affiliation: 'School',
        });
        
        participant.save(function() {
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
    		
    		user.save(function())
        })
        
    });
    
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

		// Save a user to the test db and create new Participant
		user.save(function() {
			participant = {
				firstName: 'Par',
				lastName: 'Ticipant',
				displayName: 'Par Ticipant',
				phone: '2059999999',
				email: 'participant@example.com',
				identity: 'Student',
				affiliation: 'UAB'
			};

			done();
		});
	});
    
    
    beforeEach(function(done) {
       
        
    });
    
    it('should be able to get Dashboard info if signed in', function(done) {
        agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);
	
				agent.get('/dashboards/' + userId)
					.expect(200)
					.end(function(req, res) {
						// Set assertion
                        res.body.dash.should.be.an.Object;
                        res.body.dash.actions.should.be.an.Array.with.lengthOf(1);
						// Call the assertion callback
						done();
					});
			
			});        
    });
    
    it('should not be able to get Dashboard info if  not signed in', function(done) {
        
    });
    
    afterEach(function(done) {
        // Remove info from test db
    })
});*/