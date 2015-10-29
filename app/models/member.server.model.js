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
var MemberSchema = Participant.discriminator('Member', 
	new Schema({ 
			address: {             // Should address be composed of subdocuments?
		type: String,
		default: '',
	},
	identity: {
		type: String,
		trim: true,
		default: '',
		required: 'Please choose an option for "Who are you ?"'
	},
	shirtSize: {
		type: String,
		required: 'Please choose a shirt size'
	},
	talent: {
		type: String,
		required: 'Please provide a talent/passion.'
	},
	affiliation: {
		type: String,
		trim: true,
		default: '',
		required: 'Please fill in the affiliation'
	},
	placeOfWorship: {
		type: String,
		trim: true,
		default: '',
	},
	communityNetworks: [String],
	extraGroups: [String],
	ortherNetworks: [String],
		
	}));


mongoose.model('Member', MemberSchema);