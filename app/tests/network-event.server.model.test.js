'use strict';

/**
 * Module dependencies.
 */
var should = require('should'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Location = mongoose.model('Location'),
	NetworkEvent = mongoose.model('NetworkEvent');

/**
 * Globals
 */
var user, eventLocation, networkEvent;

/**
 * Unit tests
 */
describe('Network event Model Unit Tests:', function() {
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
			eventLocation = new Location({
				name: 'New Location'
			});
			
			eventLocation.save(function() {
				
				networkEvent = new NetworkEvent({
					name: 'Network event Name',
					eventType: 'Raise Up Network',
					location: eventLocation.id,
					user: user
				});

				done();
				
			});
		});
	});

	describe('Method Save', function() {
		it('should be able to save without problems', function(done) {
			return networkEvent.save(function(err) {
				should.not.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save without name', function(done) { 
			networkEvent.name = '';

			return networkEvent.save(function(err) {
				should.exist(err);
				done();
			});
		});
	});

	afterEach(function(done) { 
		NetworkEvent.remove().exec();
		Location.remove().exec();
		User.remove().exec();

		done();
	});
});