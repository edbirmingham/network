'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

/**
 * Member Schema
 */
var MemberSchema = new Schema({
	firstName: {
		type: String,
		trim: true,
		default: '',
		required: 'Please fill in the first name'
	},
	lastName: {
		type: String,
		trim: true,
		default: '',
		required: 'Please fill in the last name'
	},
	displayName: {
		type: String,
		trim: true
	},
	member: {
		type: Boolean,
		default: true,
	},
	phone: {
		type: String,
		trim: true,
		default: '',
		required: 'Please fill in the phone'
	},
	email: {
		type: String,
		trim: true,
		default: '',
		validate: [/^\s*$|.+\@.+\..+/, 'Please provide a valid email address']
	},
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
	communityNetworks: {
		network1: {type: String},
		network2: {type: String},
		network3: {type: String}
	},
	extraGroups: {                            //is this the best way to store these groups
		group1: {type: String},
		group2: {type: String},
		group3: {type: String},
	},
	otherNetworks: {
		otherNetwork1: {type: String},
		otherNetwork2: {type: String},
		otherNetwork3: {type: String},
	},
	created: {
		type: Date,
		default: Date.now
	},
	user: {
		type: Schema.ObjectId,
		ref: 'User'
	}
});

mongoose.model('Member', MemberSchema);