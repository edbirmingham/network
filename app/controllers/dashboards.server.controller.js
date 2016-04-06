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
		dateStart = new Date(now.getYear(), 7, 1);
	}
	else {
		dateStart = new Date(now.getYear() - 1, 7, 1);
	}
	return dateStart;
};

var getLastSem = function() {
	var dateRange = [];
	// get start of previous semester
	var startDate;
	var endDate;
	if(now.getMonth() >= 7) {
		startDate = new Date(now.getYear(),1,1 );
		endDate = startDate;
	} else {
		// TODO FIX this part
		startDate = new Date(now.getYear() - 1,1,1 );
		endDate = startDate;
	}
	
	dateRange[0] = startDate;
	dateRange[1] = endDate;
	return dateRange;
};

var getLastMonth = function() {
	var dateRange = [];
	var lastMonthStart = new Date(now.getFullYear(), now.getMonth() - 1, 1);
	dateRange[0] = lastMonthStart;
	dateRange[1] = new Date(lastMonthStart.getYear(), lastMonthStart.getMonth() + 1, 0);
	return dateRange;
};


var yearToDate = getYearToDate();
var lastSem = getLastSem();
var lastMonth = getLastMonth();


// get list of all members registered by connector
var getRegisteredMembers = function(req, res) {
	var query = {};
	if(req.query.connector) {
		query.connector = req.query.connector;
	}
	query.became_member = {$gt: yearToDate[0]};
	Member.find(query)
		.exec(function(err, members) {
   			if(err) {
   				return res.status(400).send({
   					message: errorHandler.getErrorMessage(err)
   				});
   			} else {
   				res.jsonp(members);
   			}
   		});
};




// return dashboard information
exports.read = function(req, res) {
	// compile dashboard information
	
	var YTDsec = (yearToDate.getTime() / 1000).toFixed(0);
	var semStart = (lastSem[0].getTime() / 1000).toFixed(0);
	var semEnd = (lastSem[1].getTime() / 1000).toFixed(0);
	var monStart = (lastMonth[0].getTime() / 1000).toFixed(0);
	var monEnd = (lastMonth[1].getTime() / 1000).toFixed(0);
	var id  = req.params.connectorId;
	
	var conQuery = {connector: id};
	
	var memQuery = {
		user: id, 
		became_member: {$gte: YTDsec}
	};
	
	var dash  = {};
	
	// Get list of connected actions
	var promise = Action.find(conQuery).exec();
	
	promise.then(function(actions) {
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
		//memQuery.became_member = month;
		return NetworkEvent.count({eventType:'Raise Up Initiatives'}).exec();
	})
	
	
	//get Raise Up attendance
	.then(function(raiseUpNights) {
		dash.raiseUpNights = raiseUpNights;
		return Participation.count({participant: id, }).exec();
	})
	.then(function(parts) {
		dash.netPercent = dash.raiseUpNights / parts;
		dash.participations = parts;
		//res.jsonp(dash);
		return NetworkEvent.count({eventType:'Connector Table Meeting'}).exec();
	})
	
	// Get Connector Table Meetings Percentage
	.then(function(tableMeetings) {
		dash.tablePercent = tableMeetings;
		return Participation.count({participant: id}).exec();
	})
	.then(function(tableParts) {
		return NetworkEvent.count({eventType:'Core Team Member'}).exec();
	})
	
	// Get 
	.then(function(coreMeetings) {
		dash.corePercent = coreMeetings;
		return Participation.count({participant: id}).exec();
	})
	.then(function(coreParts) {
		dash.corePercent = coreParts;
		res.jsonp(dash);
	});
	
	
//	var promise = Member.find({_id: userId,}).count().exec();
	
	
	//res.jsonp(dash);
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

	