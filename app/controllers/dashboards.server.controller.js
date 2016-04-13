'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	errorHandler = require('./errors.server.controller'),
	Member = mongoose.model('Member'),
	Action = mongoose.model('Action'),
	NetworkEvent = mongoose.model('NetworkEvent'),
	Participation = mongoose.model('Participation'),
	User = mongoose.model('User'),
	_ = require('lodash');
	

var now = new Date();

var getYearToDate = function() {
	// get start of previous Sept.
	var dateRange = [];
	// if currently after August
	var dateStart;
	if(now.getMonth() >= 7) {
		dateStart = new Date(now.getFullYear(), 7, 1);
	}
	else {
		dateStart = new Date(now.getFullYear() - 1, 7, 1);
	}
	return dateStart;
};

var getLastSem = function() {
	var dateRange = [];
	// get start of previous semester
	var startDate;
	var endDate;
	if(now.getMonth() >= 7) {
		startDate = new Date(now.getFullYear(),0,1);
		endDate = new Date(startDate.getFullYear(),7,0);
	} else {
		// TODO FIX this part
		startDate = new Date(now.getFullYear() - 1,7,1);
		endDate = new Date(now.getFullYear(),0,0);
	}
	
	dateRange[0] = startDate;
	dateRange[1] = endDate;
	return dateRange;
};

var getLastMonth = function() {
	var dateRange = [];
	var lastMonthStart = new Date(now.getFullYear(), now.getMonth() - 1, 1);
	dateRange[0] = lastMonthStart;
	dateRange[1] = new Date(lastMonthStart.getFullYear(), lastMonthStart.getMonth() + 1, 0);
	return dateRange;
};


var yearToDate = getYearToDate();
var lastSem = getLastSem();
var lastMonth = getLastMonth();
console.log(yearToDate);
console.log(lastSem[0], lastSem[1]);
console.log(lastMonth[0], lastMonth[1]);

// return dashboard information
exports.read = function(req, res) {
	// compile dashboard information
	
	var YTDsec = (yearToDate.getTime() / 1000).toFixed(0);
	var semStart = (lastSem[0].getTime() / 1000).toFixed(0);
	var semEnd = (lastSem[1].getTime() / 1000).toFixed(0);
	var monStart = (lastMonth[0].getTime() / 1000).toFixed(0);
	var monEnd = (lastMonth[1].getTime() / 1000).toFixed(0);
	var id  = req.params.connectorId;
	var participant = req.params.participantId;
	
	var conQuery = {connector: id};
	
	var memQuery = {
		user: id, 
		became_member: {$gte: YTDsec}
	};
	
	var dash  = {};
	
	// Get list of connected actions
	var actionPromise = Action.find(conQuery).exec();
	
	actionPromise.then(function(actions) {
		//dash.actions = [];
		dash.actions = actions;
		return Member.count(memQuery).exec();
	})
	
	// get members
	.then(function(yearMembers) {
		dash.yearMembers = yearMembers;
		memQuery.became_member = {$gte: semStart, $lt: semEnd};
		// Get semester members
		return Member.count(memQuery).exec();
	})
	.then(function(semMembers) {
		dash.semMembers = semMembers;
		memQuery.became_member = {$gte: monStart, $lt: monEnd};
		// Get month members
		return Member.count(memQuery).exec();
	})
	
	.then(function(monthMembers) {
		dash.monthMembers = monthMembers;
	//	console.log('Participant field: ' + participant);
		return NetworkEvent.find({eventType:'Raise Up Initiatives'}).exec();
	})
	.then(function(raiseUps) {
		var raiseIds = [];
		for(var idx = 0; idx < raiseUps.length; idx++) {
			raiseIds.push(raiseUps[idx]._id);
		}
		dash.raiseIds = raiseIds;
		console.log('Array: ' + dash.raiseIds);
		console.log(dash.raiseIds.length);
		return Participation.count({participant: '56e5bc7a30c2b2cf032038d8'})
							.where('networkEvent')
							.in(raiseIds)
							.exec();
	})
	
	//get Raise Up attendance
	.then(function(participations) {
		console.log('Participation Count: ' + participations);
		dash.raisePercent = (participations / parseFloat(dash.raiseIds.length) * 100).toFixed(0);
		return NetworkEvent.find({eventType:'Connector Table Meeting'}).exec();
	
	})
	
	
	
	
	// Get Connector Table Meetings Percentage
	.then(function(tableMeetings) {
		var tableIds = [];
		for(var idx = 0; idx < tableMeetings.length; idx++) {
			tableIds.push(tableMeetings[idx]._id);
		}
		dash.tableIds = tableIds;
		console.log('Array: ' + tableIds);
		console.log('Count: ' + tableIds.length);
		return Participation.count({participant: '56e5bc7a30c2b2cf032038d8'})
							.where('networkEvent')
							.in(tableIds)
							.exec();
	})
	
	// Get 
	.then(function(participations) {
		console.log('Participation Count: ' + participations);
		dash.tablePercent = (participations / parseFloat(dash.tableIds.length) * 100).toFixed(0);
		return NetworkEvent.find({eventType:'Core Team Meeting'}).exec();
	})
	
	
	
	
	.then(function(coreMeetings) {
		var coreIds = [];
		for(var idx = 0; idx < coreMeetings.length; idx++) {
			coreIds.push(coreMeetings[idx]._id);
		}
		dash.coreIds = coreIds;
		console.log('Array: ' + coreIds);
		console.log('Count: ' + coreIds.length);
		return Participation.count({participant: '56e5bc7a30c2b2cf032038d8'})
							.where('networkEvent')
							.in(coreIds)
							.exec();
	})
	.then(function(participations) {
		dash.corePercent = (participations / parseFloat(dash.coreIds.length) * 100).toFixed(0);
		res.jsonp(dash);
	});
};

/**
 * Connector middleware
 */
exports.connectorByID = function(req, res, next, id) { 
	User.findById(id)
		.populate('participant', 'displayName')
		.exec(function(err, user) {
		if (err) return next(err);
		if (! user) return next(new Error('Failed to load Connector ' + id));
		req.requested_user = user ;
		next();
	});
};

	