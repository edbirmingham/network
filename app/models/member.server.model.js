'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema,    
	participant = require('./participant.server.model'),
	Participant = mongoose.model('Participant'),
	_ = require('lodash');

/**
 * Member Schema
 */
var MemberSchema = Participant.discriminator('Member', new Schema({ 
	address: {             
		type: String,
		default: '',
	},
	shirtSize: {
		type: String,
		required: 'Please choose a shirt size'
	},
	shirtReceived: {
		type: Boolean
	},
	talent: {
		type: String,
		trim: true,
		required: 'Please provide a talent/passion.'
	},
	placeOfWorship: {
		type: String,
		trim: true,
		default: '',
	},
	recruitment: {
		type: String,
		required: 'Please provide a recruiter.'
	},
	communityNetworks: [String],
	extraGroups: [String],
	otherNetworks: [String],
}));


mongoose.model('Member', MemberSchema);