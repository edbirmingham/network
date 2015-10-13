'use strict';

/**
 * Module dependencies.
 */
var should = require('should'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Participant = mongoose.model('Participant');

/**
 * Globals
 */
var user, participant;

/**
 * Unit tests
 */
describe('Participant Model Unit Tests:', function() {
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

			done();
		});
	});

	describe('Method Save', function() {
		it('should be able to save without problems', function(done) {
			return participant.save(function(err) {
				should.not.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save without a first name', function(done) { 
			participant.firstName = '';

			return participant.save(function(err) {
				should.exist(err);
				done();
			});
		});
	});

	afterEach(function(done) { 
		Participant.remove().exec();
		User.remove().exec();

		done();
	});
});