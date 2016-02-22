'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

/**
 * Participation Schema
 */
var ParticipationSchema = new Schema({
	participant: {
		type: Schema.ObjectId,
		ref: 'Participant',
		required: 'Please specify a Participant'
	},
	networkEvent: {
		type: Schema.ObjectId,
		ref: 'NetworkEvent',
		required: 'Please specify an Event'
	},
	attendees: {
		type: Number,
		default: 1
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

ParticipationSchema.index({ participant: 1, networkEvent: 1 }, { unique: true, dropDups: true });
mongoose.model('Participation', ParticipationSchema);
