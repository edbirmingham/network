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

var getPercentage = function(part, total) {
	if(total === 0) {
		return parseFloat(100).toFixed(0);
	}
	else {
		var percent = (part / parseFloat(total) * 100);
		return percent.toFixed(0);
	}
};


//console.log(yearToDate);
//console.log(lastSem[0], lastSem[1]);
//console.log(lastMonth[0].getTime(), lastMonth[1].getTime());

// return dashboard information
exports.read = function(req, res) {

	var yearToDate = getYearToDate();
	var lastSem = getLastSem();
	var lastMonth = getLastMonth();
	
	// compile dashboard information
	var participantId = req.user.participant;
	var participantQuery = { participant: participantId };
	var id  = req.params.connectorId;
	var conQuery = { connector: id };
	var memQuery = { user : id };
	
	var dash  = {};
	
	// Get list of connected actions
	var actionPromise = Action.find(conQuery).exec();
	
	actionPromise.then(function(actions) {
		dash.actions = actions;
		
		return Member
				.count(memQuery)
				.where('became_member').gt(yearToDate)
				.exec();
	})
	
	// get members
	.then(function(yearMembers) {
		dash.yearMembers = yearMembers;
	//	console.log(yearMembers[0].became_member);
	//	console.log(yearMembers[1].became_member);
//		console.log(yearMembers);
		// Get semester members
		return Member
				.count(memQuery)
				.where('became_member').gt(lastSem[0]).lt(lastSem[1])
				.exec();
	})
	.then(function(semMembers) {
		dash.semMembers = semMembers;
		// Get month members
		return Member
				.count(memQuery)
				.where('became_member').gt(lastMonth[0]).lt(lastMonth[1])
				.exec();
	})
	
	.then(function(monthMembers) {
		dash.monthMembers = monthMembers;
		return NetworkEvent.find({eventType:'Raise Up Initiatives'}).exec();
	})
	.then(function(raiseUps) {
		var raiseIds = [];
		for(var idx = 0; idx < raiseUps.length; idx++) {
			raiseIds.push(raiseUps[idx]._id);
		}
		dash.raiseIds = raiseIds;
		return Participation.count({participant: participantId})
							.where('networkEvent')
							.in(raiseIds)
							.exec();
	})
	
	//get Raise Up attendance
	.then(function(participations) {
		dash.raisePercent = getPercentage(participations, dash.raiseIds.length);
		return NetworkEvent.find({eventType:'Connector Table Meeting'}).exec();
	
	})
	
	
	// Get Connector Table Meetings Percentage
	.then(function(tableMeetings) {
		var tableIds = [];
		for(var idx = 0; idx < tableMeetings.length; idx++) {
			tableIds.push(tableMeetings[idx]._id);
		}
		dash.tableIds = tableIds;
		return Participation.count({participant: participantId})
							.where('networkEvent')
							.in(tableIds)
							.exec();
	})
	
	// Get 
	.then(function(participations) {
		dash.tablePercent = getPercentage(participations, dash.tableIds.length);
		return NetworkEvent.find({eventType:'Core Team Meeting'}).exec();
	})
	
	
	
	
	.then(function(coreMeetings) {
		var coreIds = [];
		for(var idx = 0; idx < coreMeetings.length; idx++) {
			coreIds.push(coreMeetings[idx]._id);
		}
		dash.coreIds = coreIds;
	//	console.log('Array: ' + coreIds);
	//	console.log('Count: ' + coreIds.length);
		return Participation.count({participant: participantId})
							.where('networkEvent')
							.in(coreIds)
							.exec();
	})
	.then(function(participations) {
		dash.corePercent = getPercentage(participations, dash.coreIds.length);
		res.jsonp(dash);
	})
	
	.then(null, function(err) {
		return res.status(401).send({
			message: errorHandler.getErrorMessage(err)
		})
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

	