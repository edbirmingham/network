'use strict';

var should = require('should'),
	request = require('supertest'),
	app = require('../../server'),
	mongoose = require('mongoose'),
	Participant = mongoose.model('Participant'),
	User = mongoose.model('User'),
	Action = mongoose.model('Action'),
	Location = mongoose.model('Location'),
	Member = mongoose.model('Member'),
	NetworkEvent = mongoose.model('NetworkEvent'),
	agent = request.agent(app);

/**
 * Globals
 */
var credentials, logged_in_user, user, participant, member, action, 
	networkEvent, eventLocation;

describe('Connector Dashboard tests', function() {
    
    beforeEach(function(done) {
    	credentials = {
    		username:'username',
    		password: 'password'
    	};
    	// create new participant
        participant = new Participant({
            firstName: 'Test',
            lastName: 'Participant',
            phone:'2223334444',
            identity: 'participant',
            affiliation: 'School',
        });
        
        participant.save(function() {
        	var user_roles = ['user', 'connector'];
            // Create a new user with participant
    		logged_in_user = new User({
    			firstName: 'Full',
    			lastName: 'Name',
    			displayName: 'Full Name',
    			email: 'test@test.com',
    			username: credentials.username,
    			password: credentials.password,
    			provider: 'local',
    			participant: participant,
    			roles: user_roles
    		});
    		
    		logged_in_user.save(function() {
    			//save member
    			member = new Member({
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
					otherNetworks: 'on1, on2, on3',
					user: logged_in_user
    			});
    			
    			member.save(function(saveErr, saveRes) {
    				if(saveErr) done(saveErr);
					action = new Action({
						actor: participant,
						type: 'Request',
						description: 'Action Description',
						matches: [participant],
						user: user,
						connector: logged_in_user
					});
					
					action.save(function() {
						
						done();
					});
    			});
    		});
    		
    		
        });
        
    });
    
    
    it('should be able to get Dashboard info if signed in', function(done) {
        agent.post('/auth/signin')
			.send(credentials)
			.expect(200)
			.end(function(signinErr, signinRes) {
				// Handle signin error
				if (signinErr) done(signinErr);
	
				var userId = logged_in_user.id;
				
				agent.get('/dashboards/' + userId)
					.expect(200)
					.end(function(dashGetErr, dashGetRes) {
						// Set assertion
                        //dashGetRes.body.dash.should.be.an.Object;
                        var dash = dashGetRes.body;
                        var mem = dash.yearMembers;
                        var connectedActions = dash.actions;
                        
                        // test action get
                        connectedActions.length.should.equal(1);
                        // get yearly member
                        mem.should.equal(1);
                        
						// Call the assertion callback
						done();
					});
			
			});        
    });
    
    it('should not be able to get Dashboard info if  not signed in', 
    function(done) {
    	agent.get('/dashboards/' + logged_in_user.id)
    		.expect(401)
    		.end(function(req, res) {
    			res.body.message.should.match('User is not logged in');
    			done();
    		});
    });
    
    afterEach(function(done) {
        // Remove info from test db
        User.remove().exec();
        Participant.remove().exec();
        Member.remove().exec();
        Action.remove().exec();
        done();
    });
});