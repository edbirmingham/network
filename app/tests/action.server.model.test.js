'use strict';

/**
 * Module dependencies.
 */
var should = require('should'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Participant = mongoose.model('Participant'),
	Action = mongoose.model('Action');

/**
 * Globals
 */
var user, action, participant;

/**
 * Unit tests
 */
describe('Action Model Unit Tests:', function() {
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

	describe('Method Save', function() {
		it('should be able to save without problems', function(done) {
			return action.save(function(err) {
				should.not.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save without actor', function(done) { 
			action.actor = '';

			return action.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without description', function(done) { 
			action.description = '';

			return action.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without type', function(done) { 
			action.type = '';

			return action.save(function(err) {
				should.exist(err);
				done();
			});
		});
	});

	afterEach(function(done) { 
		Action.remove().exec();
		User.remove().exec();
		Participant.remove().exec();

		done();
	});
});