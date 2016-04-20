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
	
	// Get year member count, query for semester count
	.then(function(yearMembers) {
		dash.yearMembers = yearMembers;
		// Get semester members
		return Member
				.count(memQuery)
				.where('became_member').gt(lastSem[0]).lt(lastSem[1])
				.exec();
	})
	//Get semester member count, query for month count
	.then(function(semMembers) {
		dash.semMembers = semMembers;
		return Member
				.count(memQuery)
				.where('became_member').gt(lastMonth[0]).lt(lastMonth[1])
				.exec();
	})
	// Get month member count, query for RaiseUp Initiatives
	.then(function(monthMembers) {
		dash.monthMembers = monthMembers;
		return NetworkEvent
				.find({eventType:'Raise Up Initiatives'})
				.where('scheduled').gt(yearToDate)
				.exec();
	})
	// handle ids, query raise participations
	.then(function(raiseUps) {
		var raiseIds = [];
		for(var idx = 0; idx < raiseUps.length; idx++) {
			raiseIds.push(raiseUps[idx]._id);
		}
		dash.raiseTotal = raiseIds.length;
		return Participation.count({participant: participantId})
							.where('networkEvent')
							.in(raiseIds)
							.exec();
	})
	
	//get Raise Up percentage, query for Table ids
	.then(function(participations) {
		dash.raisePercent = getPercentage(participations, dash.raiseTotal);
		return NetworkEvent
				.find({eventType:'Connector Table Meeting'})
				.where('scheduled').gt(yearToDate)
				.exec();
	})
	
	// Get Connector Table Meetings Percentage
	.then(function(tableMeetings) {
		var tableIds = [];
		for(var idx = 0; idx < tableMeetings.length; idx++) {
			tableIds.push(tableMeetings[idx]._id);
		}
		dash.tableTotal = tableIds.length;
		return Participation.count({participant: participantId})
							.where('networkEvent')
							.in(tableIds)
							.exec();
	})
	
	// calculate table percentage, query core meetings
	.then(function(participations) {
		dash.tablePercent = getPercentage(participations, dash.tableTotal);
		return NetworkEvent
				.find({eventType:'Core Team Meeting'})
				.where('scheduled').gt(yearToDate)
				.exec();
	})
	// handle core ids, query for core participations
	.then(function(coreMeetings) {
		var coreIds = [];
		for(var idx = 0; idx < coreMeetings.length; idx++) {
			coreIds.push(coreMeetings[idx]._id);
		}
		dash.coreTotal = coreIds.length;
		return Participation.count({participant: participantId})
							.where('networkEvent')
							.in(coreIds)
							.exec();
	})
	// calculate core Table percentage, send dashboard
	.then(function(participations) {
		dash.corePercent = getPercentage(participations, dash.coreTotal);
		res.jsonp(dash);
	})
	
	// Catch any errors	
	.then(null, function(err) {
		return res.status(401).send({
			message: errorHandler.getErrorMessage(err)
		});
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

	