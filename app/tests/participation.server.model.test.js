'use strict';

/**
 * Module dependencies.
 */
var should = require('should'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Participation = mongoose.model('Participation'),
	Participant = mongoose.model('Participant'),
	NetworkEvent = mongoose.model('NetworkEvent');

/**
 * Globals
 */
var user, participation, participant, networkEvent;

/**
 * Unit tests
 */
describe('Participation Model Unit Tests:', function() {
	beforeEach(function(done) {
		user = new User({
			firstName: 'Full',
			lastName: 'Name',
			displayName: 'Full Name',
			email: 'test@test.com',
			username: 'username',
			password: 'password'
		});

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
				networkEvent = new NetworkEvent({
					name: 'Network event Name',
					eventType: 'Raise Up Network',
					location: '525cf20451979dea2c000001',
					user: user
				});
				
				networkEvent.save(function(){
					participation = new Participation({
						participant: participant,
						networkEvent: networkEvent,
						attendees: 2,
						user: user
					});
		
					done();
				});
			});
		});
	});

	describe('Method Save', function() {
		it('should be able to save without problems', function(done) {
			return participation.save(function(err) {
				should.not.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save without a participant', function(done) { 
			participation.participant = '';

			return participation.save(function(err) {
				should.exist(err);
				done();
			});
		});
	});

	afterEach(function(done) { 
		Participation.remove().exec();
		Participant.remove().exec();
		NetworkEvent.remove().exec();
		User.remove().exec();

		done();
	});
});