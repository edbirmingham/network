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
		default: ''
	},
	shirtReceived: {
		type: Boolean,
		default: false,
	},
	talent: {
		type: String,
		trim: true,
		default: ''
	},
	placeOfWorship: {
		type: String,
		trim: true,
		default: '',
	},
	recruitment: {
		type: String,
		default: ''
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
	},
	became_member: {
		type: Date,
		default: new Date(2016, 0, 1, 18, 0 , 0)
	}
}));


mongoose.model('Member', MemberSchema);