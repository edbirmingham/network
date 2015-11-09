'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

/**
 * Action Schema
 */
var ActionSchema = new Schema({
	networkEvent: {
		type: Schema.ObjectId,
		ref: 'NetworkEvent'
	},
	actor: {
		type: Schema.ObjectId,
		ref: 'Participant',
		required: 'Please select the actor'
	},
	type: {
		type: String,
		default: '',
		required: 'Please select an action type'
	},
	description: {
		type: String,
		default: '',
		required: 'Please fill action description',
		trim: true
	},
	matches: [{type: Schema.ObjectId, ref: 'Participant'}],
	created: {
		type: Date,
		default: Date.now
	},
	user: {
		type: Schema.ObjectId,
		ref: 'User'
	}
});

mongoose.model('Action', ActionSchema);