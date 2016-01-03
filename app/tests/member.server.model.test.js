'use strict';

/**
 * Module dependencies.
 */
var should = require('should'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Member = mongoose.model('Member');

/**
 * Globals
 */
var user, member;

/**
 * Unit tests
 */
describe('Member Model Unit Tests:', function() {
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
			member = new Member({
				firstName: 'Member',
				lastName: 'Name',
				displayName: 'MemberName',
				phone: '2055558888',
				email: 'mem@email.com',
				identity: 'Educator',
				affiliation: 'UAB',
				address: '1234 Broadt Street',
				shirtSize: 'XL',
				shirtReceived: true,
				talent: 'Music',
				placeOfWorship: 'Baptist Church',
				recruitment: 'Network Night',
				communityNetworks: ['cn1', 'cn2', 'cn3'],
				extraGroups: ['eg1', 'eg2'],
				otherNetworks: ['on1', 'on2', 'on3'],
				user: user
			});

			done();
		});
	});

	describe('Method Save', function() {
		it('should be able to save without problems', function(done) {
			return member.save(function(err) {
				should.not.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save without first name', function(done) { 
			member.firstName = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without last name', function(done) { 
			member.lastName = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without a phone number', function(done) { 
			member.phone = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without an identity', function(done) { 
			member.identity = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without an affiliation', function(done) { 
			member.affiliation = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without a shirt size', function(done) { 
			member.shirtSize = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without a talent', function(done) { 
			member.talent = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
		
		it('should be able to show an error when try to save without a recruitment', function(done) { 
			member.recruitment = '';

			return member.save(function(err) {
				should.exist(err);
				done();
			});
		});
	});

	afterEach(function(done) { 
		Member.remove().exec();
		User.remove().exec();

		done();
	});
});