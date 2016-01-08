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
	city: {             
		type: String,
		default: '',
	},
	state: {             
		type: String,
		default: '',
	},
	zipCode: {             
		type: String,
		default: '',
	},
	shirtSize: {
		type: String,
		required: 'Please choose a shirt size'
	},
	shirtReceived: {
		type: Boolean,
		default: false,
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
	communityNetworks: {
		type: String,
		trim: true,
		default: '',
	},
	extraGroups: {
		type: String,
		trim: true,
		default: '',
	},
	otherNetworks: {
		type: String,
		trim: true,
		default: '',
	}
}));


mongoose.model('Member', MemberSchema);