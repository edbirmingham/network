'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

/**
 * Network event Schema
 */
var NetworkEventSchema = new Schema({
	name: {
		type: String,
		default: '',
		required: 'Please fill Network event name',
		trim: true
	},
	eventType: {
		type: String,
		default: '',
		required: 'Please select an event type'
	},
	location: {
		type: Schema.ObjectId,
		ref: 'Location',
		required: 'Please select a location'
	},
	scheduled: {
		type: Date,
		default: Date.now,
		required: 'Please provide a scheduled date'
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

mongoose.model('NetworkEvent', NetworkEventSchema);