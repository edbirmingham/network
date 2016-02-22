'use strict';

// Init the application configuration module for AngularJS application
var ApplicationConfiguration = (function() {
	// Init module configuration options
	var applicationModuleName = 'network';
	var applicationModuleVendorDependencies = ['ngResource', 'ngCookies',  'ngAnimate',  'ngTouch',  'ngSanitize',  'ui.router', 'ui.bootstrap', 'ui.utils'];

	// Add a new vertical module
	var registerModule = function(moduleName, dependencies) {
		// Create angular module
		angular.module(moduleName, dependencies || []);

		// Add the module to the AngularJS configuration file
		angular.module(applicationModuleName).requires.push(moduleName);
	};

	return {
		applicationModuleName: applicationModuleName,
		applicationModuleVendorDependencies: applicationModuleVendorDependencies,
		registerModule: registerModule
	};
})();
'use strict';

//Start by defining the main module and adding the module dependencies
angular.module(ApplicationConfiguration.applicationModuleName, ApplicationConfiguration.applicationModuleVendorDependencies);

// Setting HTML5 Location Mode
angular.module(ApplicationConfiguration.applicationModuleName).config(['$locationProvider',
	function($locationProvider) {
		$locationProvider.hashPrefix('!');
	}
]);

//Then define the init function for starting up the application
angular.element(document).ready(function() {
	//Fixing facebook bug with redirect
	if (window.location.hash === '#_=_') window.location.hash = '#!';

	//Then init the app
	angular.bootstrap(document, [ApplicationConfiguration.applicationModuleName]);
});
'use strict';

// Use applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('actions');
'use strict';

// Use Applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('core');
'use strict';

// Use applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('locations');
'use strict';

// Use applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('members');
'use strict';

// Use applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('network-events');
'use strict';

// Use applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('participants');
'use strict';

// Use applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('participations');
'use strict';

// Use applicaion configuration module to register a new module
ApplicationConfiguration.registerModule('users');
'use strict';

// Configuring the Articles module
angular.module('actions').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Actions', 'actions', 'dropdown', '/actions(/create)?');
		Menus.addSubMenuItem('topbar', 'actions', 'List Actions', 'actions');
		Menus.addSubMenuItem('topbar', 'actions', 'New Action', 'actions/create');
	}
]);
'use strict';

//Setting up route
angular.module('actions').config(['$stateProvider',
	function($stateProvider) {
		// Actions state routing
		$stateProvider.
		state('listActions', {
			url: '/actions',
			templateUrl: 'modules/actions/views/list-actions.client.view.html'
		}).
		state('createAction', {
			url: '/actions/create',
			templateUrl: 'modules/actions/views/create-action.client.view.html'
		}).
		state('viewAction', {
			url: '/actions/:actionId',
			templateUrl: 'modules/actions/views/view-action.client.view.html'
		}).
		state('editAction', {
			url: '/actions/:actionId/edit',
			templateUrl: 'modules/actions/views/edit-action.client.view.html'
		});
	}
]);
'use strict';

// Actions controller
angular.module('actions').controller('ActionsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Actions', 'Participants', 'NetworkEvents', 'Locations', 'Users',
	function($scope, $stateParams, $location, Authentication, Actions, Participants, NetworkEvents, Locations, Users) {
		$scope.authentication = Authentication;

		if (!$scope.authentication.user) $location.path('/signin');

        // Retrieve the list of possible events for the action.
        $scope.networkEvents = NetworkEvents.query();
        
		// Create new Action
		$scope.create = function() {
			$scope.action = $scope.action || {};
			
			var match_ids = [];
			angular.forEach($scope.matches, function(match){
				this.push(match._id);
			}, match_ids);
			
			var networkEventID = null;
			var locationID = null;
			if ($scope.networkEvent) {
				networkEventID = $scope.networkEvent._id;
				locationID = $scope.networkEvent.location._id;
			}
			
			var actorID = null;
			if ($scope.actor) {
				actorID = $scope.actor._id;
			}
			
			// Create new Action object
			var action = new Actions ({
				networkEvent: networkEventID,
				location: locationID,
				actor: actorID,
				type: $scope.action.type,
				description: $scope.action.description,
				matches: match_ids
			});

			// Redirect after save
			action.$save(function(response) {
				$location.path('actions/create');
				
				// Show success message
				$scope.success = $scope.actor.displayName + '\'s action was successfully added.';
				
				// Clear form fields
				$scope.actor = null;
				$scope.action.type = null;
				$scope.action.description = null;
				$scope.matches = [];
				$scope.selectedMatch = null;
				
				// Focus on selecting the next actor.
				var actor_input = document.querySelector('#actor');
				if (actor_input) {
					actor_input.focus();
				}
			}, function(errorResponse) {
				$scope.success = null;
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Action
		$scope.remove = function(action) {
			if ( action ) { 
				action.$remove();

				for (var i in $scope.actions) {
					if ($scope.actions [i] === action) {
						$scope.actions.splice(i, 1);
					}
				}
			} else {
				$scope.action.$remove(function() {
					$location.path('actions');
				});
			}
		};

		// Update existing Action
		$scope.update = function() {
			var action = $scope.action;

			action.$update(function() {
				$location.path('actions/' + action._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Actions
		$scope.find = function() {
			$scope.actions = Actions.query();
			$scope.locations = Locations.query();
			$scope.connectors = Users.query();
		};
		
		// Filter list of actions by location
		$scope.filterActions = function() {
			var query = {};
			if ($scope.location) {
				query.location = $scope.location._id;
			}
			if ($scope.connector) {
				query.connector = $scope.connector._id;
			}
			if ($scope.status){
				query.status = $scope.status;
			}
			$scope.actions = Actions.query(query);
			
		};

		// Find existing Action
		$scope.findOne = function() {
			$scope.action = Actions.get({ 
				actionId: $stateParams.actionId
			});
			$scope.connectors = Users.query();
		};
		
		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};
		
		// Initialize the create action form
		$scope.newAction = function() {
			$scope.actor = null;
			$scope.matches = [];
		};
		
		// Add the selected match to the match list.
		$scope.addMatch = function(matches, match) {
			matches.push(match);
			$scope.selectedMatch = null;
		};
		
		// Remove match from the match list.
		$scope.removeMatch = function(matches, matchIndex) {
			matches.splice(matchIndex, 1);
		};
	}
]);
'use strict';

//Actions service used to communicate Actions REST endpoints
angular.module('actions').factory('Actions', ['$resource',
	function($resource) {
		var Action = $resource('actions/:actionId', { actionId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
		
		return Action;
	}
]);
'use strict';

// Setting up route
angular.module('core').config(['$stateProvider', '$urlRouterProvider',
	function($stateProvider, $urlRouterProvider) {
		// Redirect to home view when route not found
		$urlRouterProvider.otherwise('/');

		// Home state routing
		$stateProvider.
		state('home', {
			url: '/',
			templateUrl: 'modules/core/views/home.client.view.html'
		});
	}
]);
'use strict';

angular.module('core').controller('HeaderController', ['$scope', 'Authentication', 'Menus',
	function($scope, Authentication, Menus) {
		$scope.authentication = Authentication;
		$scope.isCollapsed = false;
		$scope.menu = Menus.getMenu('topbar');

		$scope.toggleCollapsibleMenu = function() {
			$scope.isCollapsed = !$scope.isCollapsed;
		};

		// Collapsing the menu after navigation
		$scope.$on('$stateChangeSuccess', function() {
			$scope.isCollapsed = false;
		});
	}
]);
'use strict';


angular.module('core').controller('HomeController', ['$scope', 'Authentication',
	function($scope, Authentication) {
		// This provides Authentication context.
		$scope.authentication = Authentication;
	}
]);
'use strict';

//Menu service used for managing  menus
angular.module('core').service('Menus', [

	function() {
		// Define a set of default roles
		this.defaultRoles = ['*'];

		// Define the menus object
		this.menus = {};

		// A private function for rendering decision 
		var shouldRender = function(user) {
			if (user) {
				if (!!~this.roles.indexOf('*')) {
					return true;
				} else {
					for (var userRoleIndex in user.roles) {
						for (var roleIndex in this.roles) {
							if (this.roles[roleIndex] === user.roles[userRoleIndex]) {
								return true;
							}
						}
					}
				}
			} else {
				return this.isPublic;
			}

			return false;
		};

		// Validate menu existance
		this.validateMenuExistance = function(menuId) {
			if (menuId && menuId.length) {
				if (this.menus[menuId]) {
					return true;
				} else {
					throw new Error('Menu does not exists');
				}
			} else {
				throw new Error('MenuId was not provided');
			}

			return false;
		};

		// Get the menu object by menu id
		this.getMenu = function(menuId) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Return the menu object
			return this.menus[menuId];
		};

		// Add new menu object by menu id
		this.addMenu = function(menuId, isPublic, roles) {
			// Create the new menu
			this.menus[menuId] = {
				isPublic: isPublic || false,
				roles: roles || this.defaultRoles,
				items: [],
				shouldRender: shouldRender
			};

			// Return the menu object
			return this.menus[menuId];
		};

		// Remove existing menu object by menu id
		this.removeMenu = function(menuId) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Return the menu object
			delete this.menus[menuId];
		};

		// Add menu item object
		this.addMenuItem = function(menuId, menuItemTitle, menuItemURL, menuItemType, menuItemUIRoute, isPublic, roles, position) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Push new menu item
			this.menus[menuId].items.push({
				title: menuItemTitle,
				link: menuItemURL,
				menuItemType: menuItemType || 'item',
				menuItemClass: menuItemType,
				uiRoute: menuItemUIRoute || ('/' + menuItemURL),
				isPublic: ((isPublic === null || typeof isPublic === 'undefined') ? this.menus[menuId].isPublic : isPublic),
				roles: ((roles === null || typeof roles === 'undefined') ? this.menus[menuId].roles : roles),
				position: position || 0,
				items: [],
				shouldRender: shouldRender
			});

			// Return the menu object
			return this.menus[menuId];
		};

		// Add submenu item object
		this.addSubMenuItem = function(menuId, rootMenuItemURL, menuItemTitle, menuItemURL, menuItemUIRoute, isPublic, roles, position) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Search for menu item
			for (var itemIndex in this.menus[menuId].items) {
				if (this.menus[menuId].items[itemIndex].link === rootMenuItemURL) {
					// Push new submenu item
					this.menus[menuId].items[itemIndex].items.push({
						title: menuItemTitle,
						link: menuItemURL,
						uiRoute: menuItemUIRoute || ('/' + menuItemURL),
						isPublic: ((isPublic === null || typeof isPublic === 'undefined') ? this.menus[menuId].items[itemIndex].isPublic : isPublic),
						roles: ((roles === null || typeof roles === 'undefined') ? this.menus[menuId].items[itemIndex].roles : roles),
						position: position || 0,
						shouldRender: shouldRender
					});
				}
			}

			// Return the menu object
			return this.menus[menuId];
		};

		// Remove existing menu object by menu id
		this.removeMenuItem = function(menuId, menuItemURL) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Search for menu item to remove
			for (var itemIndex in this.menus[menuId].items) {
				if (this.menus[menuId].items[itemIndex].link === menuItemURL) {
					this.menus[menuId].items.splice(itemIndex, 1);
				}
			}

			// Return the menu object
			return this.menus[menuId];
		};

		// Remove existing menu object by menu id
		this.removeSubMenuItem = function(menuId, submenuItemURL) {
			// Validate that the menu exists
			this.validateMenuExistance(menuId);

			// Search for menu item to remove
			for (var itemIndex in this.menus[menuId].items) {
				for (var subitemIndex in this.menus[menuId].items[itemIndex].items) {
					if (this.menus[menuId].items[itemIndex].items[subitemIndex].link === submenuItemURL) {
						this.menus[menuId].items[itemIndex].items.splice(subitemIndex, 1);
					}
				}
			}

			// Return the menu object
			return this.menus[menuId];
		};

		//Adding the topbar menu
		this.addMenu('topbar');
	}
]);
'use strict';

// Configuring the Articles module
angular.module('locations').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Locations', 'locations', 'dropdown', '/locations(/create)?');
		Menus.addSubMenuItem('topbar', 'locations', 'List Locations', 'locations');
		Menus.addSubMenuItem('topbar', 'locations', 'New Location', 'locations/create');
	}
]);
'use strict';

//Setting up route
angular.module('locations').config(['$stateProvider',
	function($stateProvider) {
		// Locations state routing
		$stateProvider.
		state('listLocations', {
			url: '/locations',
			templateUrl: 'modules/locations/views/list-locations.client.view.html'
		}).
		state('createLocation', {
			url: '/locations/create',
			templateUrl: 'modules/locations/views/create-location.client.view.html'
		}).
		state('viewLocation', {
			url: '/locations/:locationId',
			templateUrl: 'modules/locations/views/view-location.client.view.html'
		}).
		state('editLocation', {
			url: '/locations/:locationId/edit',
			templateUrl: 'modules/locations/views/edit-location.client.view.html'
		});
	}
]);

'use strict';

// Locations controller
angular.module('locations').controller('LocationsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Locations',
	function($scope, $stateParams, $location, Authentication, Locations) {
		$scope.authentication = Authentication;

		if (!$scope.authentication.user) $location.path('/signin');

		// Create new Location
		$scope.create = function() {
			// Create new Location object
			var location = new Locations ({
				name: this.name
			});

			// Redirect after save
			location.$save(function(response) {
				$location.path('locations/' + response._id);

				// Clear form fields
				$scope.name = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Location
		$scope.remove = function(location) {
			if ( location ) { 
				location.$remove();

				for (var i in $scope.locations) {
					if ($scope.locations [i] === location) {
						$scope.locations.splice(i, 1);
					}
				}
			} else {
				$scope.location.$remove(function() {
					$location.path('locations');
				});
			}
		};

		// Update existing Location
		$scope.update = function() {
			var location = $scope.location;

			location.$update(function() {
				$location.path('locations/' + location._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Locations
		$scope.find = function() {
			$scope.locations = Locations.query();
		};

		// Find existing Location
		$scope.findOne = function() {
			$scope.location = Locations.get({ 
				locationId: $stateParams.locationId
			});
		};
	}
]);
'use strict';

//Locations service used to communicate Locations REST endpoints
angular.module('locations').factory('Locations', ['$resource',
	function($resource) {
		return $resource('locations/:locationId', { locationId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);
'use strict';

// Configuring the Articles module
angular.module('members').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Members', 'members', 'dropdown', '/members(/create)?');
		Menus.addSubMenuItem('topbar', 'members', 'List Members', 'members');
		Menus.addSubMenuItem('topbar', 'members', 'New Member', 'members/create');
	}
]);
'use strict';

//Setting up route
angular.module('members').config(['$stateProvider',
	function($stateProvider) {
		// Members state routing
		$stateProvider.
		state('listMembers', {
			url: '/members',
			templateUrl: 'modules/members/views/list-members.client.view.html'
		}).
		state('createMember', {
			url: '/members/create',
			templateUrl: 'modules/members/views/create-member.client.view.html'
		}).
		state('viewMember', {
			url: '/members/:memberId',
			templateUrl: 'modules/members/views/view-member.client.view.html'
		}).
		state('editMember', {
			url: '/members/:memberId/edit',
			templateUrl: 'modules/members/views/edit-member.client.view.html'
		});
	}
]);
'use strict';

// Members controller
angular.module('members').controller('MembersController', ['$scope', '$stateParams', '$location', 'Authentication', 'Members', 'Participants',
	function($scope, $stateParams, $location, Authentication, Members, Participants) {
		$scope.authentication = Authentication;
		$scope.errorStatus = {};

		if (!$scope.authentication.user) $location.path('/signin');

		$scope.dateToFilterBy = null;
		$scope.status = { dateOpen: false };

		$scope.open = function($event) {
		    $event.preventDefault();
		    $event.stopPropagation();

		    $scope.status.dateOpen = !$scope.status.dateOpen;
		  };

		$scope.setErrors = function(errors) {
			$scope.errorStatus = {};
			if (errors.fields) {
				for (var ei in errors.fields) {
					$scope.errorStatus[errors.fields[ei]] = 'has-error';
				}
			}
			$scope.errorMessages = errors.messages;
		};

		// Create new Member
		$scope.create = function() {

			var clearFields = function(Participant) {
				$scope.errorMessages = null;
				$scope.errorStatus = {};
				$scope.member.firstName = '';
				$scope.member.lastName = '';
				$scope.member.phone = '';
				$scope.member.email = '';
				$scope.member.identity = '';
				$scope.member.affiliation = '';
				$scope.member.address = '';
				$scope.member.city = '';
				$scope.member.state = '';
				$scope.member.zipCode = '';
				$scope.member.shirtSize = '';
				$scope.member.shirtReceived = '';
				$scope.member.talent = '';
				$scope.member.placeOfWorship = '';
				$scope.member.recruitment = '';
				$scope.member.communityNetworks = '';
				$scope.member.extraGroups = '';
				$scope.member.otherNetworks = '';
			};

			// Create new Member
			var member = $scope.member;

			if(member && member._id) {
				member.$update(function(response) {
					$location.path('members/' + response._id);
					clearFields(response);
				}, function(errorResponse) {
				    $scope.error = errorResponse.data.message;
				    $scope.errors = $scope.setErrors(errorResponse.data);

				});

			} else {
				// Redirect after save
				member.$save(function(response) {
					$location.path('members/' + response._id);
					clearFields(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				    $scope.errors = $scope.setErrors(errorResponse.data);
				});

			}
		};

		// Remove existing Member
		$scope.remove = function(member) {
			if ( member ) {
				member.$remove();

				for (var i in $scope.members) {
					if ($scope .members [i] === member) {
						$scope.members.splice(i, 1);
					}
				}
			} else {
				$scope.member.$remove(function() {
					$location.path('members');
				});
			}
		};

		// Update existing Member
		$scope.update = function() {
			var member = $scope.member;

			member.$update(function() {
				$location.path('members/' + member._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			    $scope.errors = $scope.setErrors(errorResponse.data);
			});
		};


		// Find a list of Members
		$scope.find = function() {
			$scope.members = Members.query();
		};

		$scope.showOnlyShirtlessMembers = false;

		$scope.shirtFilter = function(member) {
			if($scope.showOnlyShirtlessMembers === true) {
				return member.shirtReceived === false;
			} else {
				return member;
			}
		};

		$scope.filterByDate = function(member) {
			if($scope.dateToFilterBy) {
				var newDate = new Date(member.created);
				return newDate >= $scope.dateToFilterBy;
			} else {
				return member;
			}

		};

		$scope.giveShirt = function(member) {
			//var member = $scope.member;
			if(member.shirtReceived === false) {
				member.shirtReceived = true;

				member.$update(function() {

				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
			}
		};

		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};

		// Find existing Member
		$scope.findOne = function() {
			$scope.member = Members.get({
				memberId: $stateParams.memberId
			});
		};

		// Initialize a new Member
		$scope.newMember = function() {
			$scope.member = new Members({
				communityNetworks: '',
				extraGroups: '',
				otherNetworks: ''
			});
		};

		// A member is selected from the typehead search
		$scope.selectMember = function(participant) {
			$scope.member = new Members(participant);
			$scope.member.communityNetworks = '';
			$scope.member.extraGroups = '';
			$scope.member.otherNetworks = '';
		};
		
		$scope.exportToExcel = function() {
			var csvData = [[
				'Name',
				'Phone',
				'Email',
				'Identity',
				'Affiliation',
				'Address',
				'City',
				'State',
				'Zip Code',
				'Shirt Size',
				'Shirt Received',
				'Talent',
				'Place of Worship',
				'Recruitment',
				'Community Networks',
				'Extra Groups',
				'Other Networks'
			]];

			for (var i = 0; i < $scope.members.length; i++) {
				var member = $scope.members[i];
				if ($scope.shirtFilter(member)) {
					csvData.push([
						member.displayName,
						member.phone,
						member.email,
						member.identity,
						member.affiliation,
						member.address,
						member.city,
						member.state,
						member.zipCode,
						member.shirtSize,
						member.shirtReceived ? 'Yes' : 'No',
						member.talent,
						member.placeOfWorship,
						member.recruitment,
						member.communityNetworks,
						member.extraGroups,
						member.otherNetworks
					].join(','));
				}
			}
			var el = document.createElement('a');
			el.id = 'downloadFile';
			el.href = 'data:text/csv;charset=utf8,' + encodeURIComponent(csvData.join('\n'));
			el.download = 'members.csv';
			
			var before = document.getElementById('exportLink');
			before.parentNode.insertBefore(el, before);
			el.click();
			el.remove();
		};
	}
]);

'use strict';

//Members service used to communicate Members REST endpoints
angular.module('members').factory('Members', ['$resource',
	function($resource) {
		return $resource('members/:memberId', { memberId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);
'use strict';

// Configuring the Articles module
angular.module('network-events').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Events', 'network-events', 'dropdown', '/network-events(/create)?');
		Menus.addSubMenuItem('topbar', 'network-events', 'List Events', 'network-events');
		Menus.addSubMenuItem('topbar', 'network-events', 'New Event', 'network-events/create');
	}
]);
'use strict';

//Setting up route
angular.module('network-events').config(['$stateProvider',
	function($stateProvider) {
		// Network events state routing
		$stateProvider.
		state('listNetworkEvents', {
			url: '/network-events',
			templateUrl: 'modules/network-events/views/list-network-events.client.view.html'
		}).
		state('createNetworkEvent', {
			url: '/network-events/create',
			templateUrl: 'modules/network-events/views/create-network-event.client.view.html'
		}).
		state('viewNetworkEvent', {
			url: '/network-events/:networkEventId',
			templateUrl: 'modules/network-events/views/view-network-event.client.view.html'
		}).
		state('editNetworkEvent', {
			url: '/network-events/:networkEventId/edit',
			templateUrl: 'modules/network-events/views/edit-network-event.client.view.html'
		});
	}
]);
'use strict';

// Network events controller
angular.module('network-events').controller('NetworkEventsController', ['$scope', '$stateParams', '$location', 'Authentication', 'NetworkEvents', 'Locations', 'Participations',
	function($scope, $stateParams, $location, Authentication, NetworkEvents, Locations, Participations) {
		$scope.authentication = Authentication;
		$scope.status = { dateOpen: false };

		if (!$scope.authentication.user) $location.path('/signin');

		$scope.open = function($event) {
		    $event.preventDefault();
		    $event.stopPropagation();
		
		    $scope.status.dateOpen = !$scope.status.dateOpen;
		  };

		// Create new Network event
		$scope.create = function() {
			// Create new Network event object
			var networkEvent = new NetworkEvents({
				name: this.networkEvent.name,
				eventType: this.networkEvent.eventType,
				location: this.networkEvent.location._id,
				scheduled: this.networkEvent.scheduled
			});

			// Redirect after save
			networkEvent.$save(function(response) {
				$location.path('network-events/' + response._id);

				// Clear form fields
				$scope.networkEvent.name = '';
				$scope.networkEvent.eventType = '';
				$scope.networkEvent.location = '';
				$scope.networkEvent.scheduled = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Network event
		$scope.remove = function(networkEvent) {
			if ( networkEvent ) { 
				networkEvent.$remove();

				for (var i in $scope.networkEvents) {
					if ($scope.networkEvents [i] === networkEvent) {
						$scope.networkEvents.splice(i, 1);
					}
				}
			} else {
				$scope.networkEvent.$remove(function() {
					$location.path('network-events');
				});
			}
		};

		$scope.removeParticipation = function(participation) {
			if (participation) {
				var $participation = new Participations(participation);
				$participation.$remove(function() {
					$scope.participations = Participations.query({
						networkEventId: $stateParams.networkEventId
					});
				});
			}
		};

		// Update existing Network event
		$scope.update = function() {
			var networkEvent = $scope.networkEvent;

			networkEvent.$update(function() {
				$location.path('network-events/' + networkEvent._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Network events
		$scope.find = function() {
			$scope.networkEvents = NetworkEvents.query();
		};

		// Find existing Network event
		$scope.findOne = function() {
			$scope.networkEvent = NetworkEvents.get({ 
				networkEventId: $stateParams.networkEventId
			});
		};
		
        // Retrieve the list of possible locations for the event.
		$scope.findLocations = function() {
	        $scope.locations = Locations.query();
		};
		
		$scope.initNew = function() {
			$scope.findLocations();
			$scope.networkEvent = new NetworkEvents({});
			$scope.networkEvent.scheduled = new Date();
			$scope.networkEvent.scheduled.setHours(19);
			$scope.networkEvent.scheduled.setMinutes(0);
			$scope.networkEvent.scheduled.setSeconds(0);
			
		};
		
		// Initialize the edit screen with the event and possible locations.
		$scope.initEdit = function() {
			$scope.findLocations();
			$scope.findOne();
		};
		
		// Initialize the view screen with the event and all the participations.
		$scope.initView = function() {
			$scope.findOne();
			$scope.participations = Participations.query({
				networkEventId: $stateParams.networkEventId
			});
		};
	}
]);
'use strict';

//Network events service used to communicate Network events REST endpoints
angular.module('network-events').factory('NetworkEvents', ['$resource', '$filter',
	function($resource, $filter) {
		var NetworkEvent = $resource('network-events/:networkEventId', { networkEventId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
		
		angular.extend(NetworkEvent.prototype, {
			listName: function() {
				return this.name + ' (' + $filter('date')(this.scheduled) + ')';
			}
		});
		
		return NetworkEvent;
	}
]);
'use strict';

// Configuring the Articles module
angular.module('participants').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Participants', 'participants', 'dropdown', '/participants(/create)?');
		Menus.addSubMenuItem('topbar', 'participants', 'List Participants', 'participants');
		Menus.addSubMenuItem('topbar', 'participants', 'New Participant', 'participants/create');
	}
]);
'use strict';

//Setting up route
angular.module('participants').config(['$stateProvider',
	function($stateProvider) {
		// Participants state routing
		$stateProvider.
		state('listParticipants', {
			url: '/participants',
			templateUrl: 'modules/participants/views/list-participants.client.view.html'
		}).
		state('createParticipant', {
			url: '/participants/create',
			templateUrl: 'modules/participants/views/create-participant.client.view.html'
		}).
		state('viewParticipant', {
			url: '/participants/:participantId',
			templateUrl: 'modules/participants/views/view-participant.client.view.html'
		}).
		state('editParticipant', {
			url: '/participants/:participantId/edit',
			templateUrl: 'modules/participants/views/edit-participant.client.view.html'
		});
	}
]);
'use strict';

// Participants controller
angular.module('participants').controller('ParticipantsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Participants',
	function($scope, $stateParams, $location, Authentication, Participants) {
		$scope.authentication = Authentication;
		$scope.errorStatus = {};

		if (!$scope.authentication.user) $location.path('/signin');

		$scope.setErrors = function(errors) {
			$scope.errorStatus = {};
			if (errors.fields) {
				for (var ei in errors.fields) {
					$scope.errorStatus[errors.fields[ei]] = 'has-error';
				}
			}
			$scope.errorMessages = errors.messages;
		};

		// Create new Participant
		$scope.create = function() {
			// Create new Participant object
			var participant = new Participants($scope.participant);

			// Redirect after save
			participant.$save(function(response) {
				$location.path('participants/' + response._id);

				// Clear form fields
				$scope.participant.firstName = '';
				$scope.participant.lastName = '';
				$scope.participant.phone = '';
				$scope.participant.email = '';
				$scope.participant.identity = '';
				$scope.participant.affiliation = '';
			}, function(errorResponse) {
				$scope.errors = $scope.setErrors(errorResponse.data);
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing Participant
		$scope.remove = function(participant) {
			if ( participant ) { 
				participant.$remove();

				for (var i in $scope.participants) {
					if ($scope.participants [i] === participant) {
						$scope.participants.splice(i, 1);
					}
				}
			} else {
				$scope.participant.$remove(function() {
					$location.path('participants');
				});
			}
		};

		// Update existing Participant
		$scope.update = function() {
			var participant = $scope.participant;

			participant.$update(function() {
				$location.path('participants/' + participant._id);
			}, function(errorResponse) {
				$scope.errors = $scope.setErrors(errorResponse.data);
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Participants
		$scope.find = function() {
			$scope.participants = Participants.query();
		};

		// Find existing Participant
		$scope.findOne = function() {
			$scope.participant = Participants.get({ 
				participantId: $stateParams.participantId
			});
		};
		$scope.initNew = function() {
		   $scope.participant = new Participants({});
		};
	}
]);
'use strict';

//Participants service used to communicate Participants REST endpoints
angular.module('participants').factory('Participants', ['$resource',
	function($resource) {
		var Participant = $resource('participants/:participantId', { participantId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
		
		angular.extend(Participant.prototype, {
			listName: function() {
				return this.displayName + ' (' + this.phone + ')';
			}
		});
		
		return Participant;
	}
]);
'use strict';

//Setting up route
angular.module('participations').config(['$stateProvider',
	function($stateProvider) {
		// Participations state routing
		$stateProvider.
		state('createParticipation', {
			url: '/network-events/:networkEventId/participations/create',
			templateUrl: 'modules/participations/views/create-participation.client.view.html'
		});
	}
]);
'use strict';

// Participations controller
angular.module('participations').controller('ParticipationsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Participations', 'NetworkEvents', 'Participants',
	function($scope, $stateParams, $location, Authentication, Participations, NetworkEvents, Participants) {
		$scope.authentication = Authentication;
		$scope.isSelectionEditable = false;

		if (!$scope.authentication.user) $location.path('/signin');

		// Create new Participation
		$scope.create = function() {
			var saveParticipation = function(attendee) {
				// Create new Participation object
				var participation = new Participations ({
					participant: attendee._id
				});
			
				// Redirect after save
				participation.$save({ networkEventId: $stateParams.networkEventId }, function(response) {
					$location.path('network-events/' + $stateParams.networkEventId + '/participations/create');
					
					$scope.success =  $scope.attendee.firstName + ' ' + $scope.attendee.lastName + ' was successfully added.';
					$scope.isSelectionEditable = false; 
					$scope.error = null;
	
					// Clear form fields
					$scope.selected = null;
					$scope.attendee = null;
					// Focus on selecting the next actor.
					var attendee_input = document.querySelector('#participant');
					if (attendee_input) {
						attendee_input.focus();
					}
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
			};
			
			// If an attendee is selected from existing participants update the attendee
			if ($scope.attendee && $scope.attendee._id) {
				// Update the attendee participant.
				$scope.attendee.$update(function(response) {
					saveParticipation(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
				
			// Otherwise create a participant to be the attendee.
			} else {
				// Create new Participant object
				var participant = new Participants($scope.attendee);
	
				// Redirect after save
				participant.$save(function(response) {
					saveParticipation(response);
				}, function(errorResponse) {
					$scope.error = errorResponse.data.message;
				});
				
			}
		};
		
		// Find existing participants
		$scope.findParticipants = function(name) {
			return Participants.query({name: name}).$promise;
		};
		
		// Find existing Network event
		$scope.newParticipation = function() {
			$scope.attendee = null;
			$scope.networkEvent = NetworkEvents.get({ 
				networkEventId: $stateParams.networkEventId
			});
		};
		
		// Clears out the selected participant without saving anything.
		$scope.clearSelection = function() {
			$scope.attendee = null; 
			$scope.selected = null;
		};
		
		// Allows the selected participant to be edited and saved.
		$scope.editSelection = function() {
			$scope.isSelectionEditable = true; 
		};
		
		// Called when the attendee name in the typeahead is changed.
		$scope.onSelectedChange = function() {
			$scope.attendee = null;
			$scope.isSelectionEditable = false; 
		};
		
		// Determine if the participant form should be shown to help prevent
		// accidentally changing information for a participant.
		$scope.showForm = function(selected, isEditable) {
			return !selected || isEditable;
		};
		
		// Determine if the selected participants attributes should be shown 
		// instead of the participant form to help prevent accidental changes
		// to a participant's information.
		$scope.showSelectedAttributes = function(selected, isEditable) {
			return selected && !isEditable;
		};
	}
]);
'use strict';

//Participations service used to communicate Participations REST endpoints
angular.module('participations').factory('Participations', ['$resource',
	function($resource) {
		return $resource('network-events/:networkEventId/participations/:participationId', { participationId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);
'use strict';

// Configuring the Users module
angular.module('users').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Users', 'users', 'dropdown', '/users(/create)?');
		Menus.addSubMenuItem('topbar', 'users', 'List Users', 'users');
		Menus.addSubMenuItem('topbar', 'users', 'New User', 'users/create');
	}
]);

// Config HTTP Error Handling
angular.module('users').config(['$httpProvider',
	function($httpProvider) {
		// Set the httpProvider "not authorized" interceptor
		$httpProvider.interceptors.push(['$q', '$location', 'Authentication',
			function($q, $location, Authentication) {
				return {
					responseError: function(rejection) {
						switch (rejection.status) {
							case 401:
								// Deauthenticate the global user
								Authentication.user = null;

								// Redirect to signin page
								$location.path('signin');
								break;
							case 403:
								// Add unauthorized behaviour 
								break;
						}

						return $q.reject(rejection);
					}
				};
			}
		]);
	}
]);
'use strict';

// Setting up route
angular.module('users').config(['$stateProvider',
	function($stateProvider) {
		// Users state routing
		$stateProvider.
		state('listUsers', {
			url: '/users',
			templateUrl: 'modules/users/views/list-users.client.view.html'
		}).
		state('createUser', {
			url: '/users/create',
			templateUrl: 'modules/users/views/create-user.client.view.html'
		}).
		state('viewUser', {
			url: '/users/:userId',
			templateUrl: 'modules/users/views/view-user.client.view.html'
		}).
		state('editUser', {
			url: '/users/:userId/edit',
			templateUrl: 'modules/users/views/edit-user.client.view.html'
		}).
		state('profile', {
			url: '/settings/profile',
			templateUrl: 'modules/users/views/settings/edit-profile.client.view.html'
		}).
		state('password', {
			url: '/settings/password',
			templateUrl: 'modules/users/views/settings/change-password.client.view.html'
		}).
		state('accounts', {
			url: '/settings/accounts',
			templateUrl: 'modules/users/views/settings/social-accounts.client.view.html'
		}).
		state('signup', {
			url: '/signup',
			templateUrl: 'modules/users/views/authentication/signup.client.view.html'
		}).
		state('signin', {
			url: '/signin',
			templateUrl: 'modules/users/views/authentication/signin.client.view.html'
		}).
		state('forgot', {
			url: '/password/forgot',
			templateUrl: 'modules/users/views/password/forgot-password.client.view.html'
		}).
		state('reset-invalid', {
			url: '/password/reset/invalid',
			templateUrl: 'modules/users/views/password/reset-password-invalid.client.view.html'
		}).
		state('reset-success', {
			url: '/password/reset/success',
			templateUrl: 'modules/users/views/password/reset-password-success.client.view.html'
		}).
		state('reset', {
			url: '/password/reset/:token',
			templateUrl: 'modules/users/views/password/reset-password.client.view.html'
		});
	}
]);
'use strict';

angular.module('users').controller('AuthenticationController', ['$scope', '$http', '$location', 'Authentication',
	function($scope, $http, $location, Authentication) {
		$scope.authentication = Authentication;

		// If user is signed in then redirect back home
		if ($scope.authentication.user) $location.path('/');

		$scope.signup = function() {
			$http.post('/auth/signup', $scope.credentials).success(function(response) {
				// If successful we assign the response to the global user model
				$scope.authentication.user = response;

				// And redirect to the index page
				$location.path('/');
			}).error(function(response) {
				$scope.error = response.message;
			});
		};

		$scope.signin = function() {
			$http.post('/auth/signin', $scope.credentials).success(function(response) {
				// If successful we assign the response to the global user model
				$scope.authentication.user = response;

				// And redirect to the index page
				$location.path('/');
			}).error(function(response) {
				$scope.error = response.message;
			});
		};
	}
]);
'use strict';

angular.module('users').controller('PasswordController', ['$scope', '$stateParams', '$http', '$location', 'Authentication',
	function($scope, $stateParams, $http, $location, Authentication) {
		$scope.authentication = Authentication;

		//If user is signed in then redirect back home
		if ($scope.authentication.user) $location.path('/');

		// Submit forgotten password account id
		$scope.askForPasswordReset = function() {
			$scope.success = $scope.error = null;

			$http.post('/auth/forgot', $scope.credentials).success(function(response) {
				// Show user success message and clear form
				$scope.credentials = null;
				$scope.success = response.message;

			}).error(function(response) {
				// Show user error message and clear form
				$scope.credentials = null;
				$scope.error = response.message;
			});
		};

		// Change user password
		$scope.resetUserPassword = function() {
			$scope.success = $scope.error = null;

			$http.post('/auth/reset/' + $stateParams.token, $scope.passwordDetails).success(function(response) {
				// If successful show success message and clear form
				$scope.passwordDetails = null;

				// Attach user profile
				Authentication.user = response;

				// And redirect to the index page
				$location.path('/password/reset/success');
			}).error(function(response) {
				$scope.error = response.message;
			});
		};
	}
]);
'use strict';

angular.module('users').controller('SettingsController', ['$scope', '$http', '$location', 'Users', 'Authentication',
	function($scope, $http, $location, Users, Authentication) {
		$scope.user = Authentication.user;

		// If user is not signed in then redirect back home
		if (!$scope.user) $location.path('/');

		// Check if there are additional accounts 
		$scope.hasConnectedAdditionalSocialAccounts = function(provider) {
			for (var i in $scope.user.additionalProvidersData) {
				return true;
			}

			return false;
		};

		// Check if provider is already in use with current user
		$scope.isConnectedSocialAccount = function(provider) {
			return $scope.user.provider === provider || ($scope.user.additionalProvidersData && $scope.user.additionalProvidersData[provider]);
		};

		// Remove a user social account
		$scope.removeUserSocialAccount = function(provider) {
			$scope.success = $scope.error = null;

			$http.delete('/users/accounts', {
				params: {
					provider: provider
				}
			}).success(function(response) {
				// If successful show success message and clear form
				$scope.success = true;
				$scope.user = Authentication.user = response;
			}).error(function(response) {
				$scope.error = response.message;
			});
		};

		// Update a user profile
		$scope.updateUserProfile = function(isValid) {
			if (isValid) {
				$scope.success = $scope.error = null;
				var user = new Users($scope.user);

				user.$update(function(response) {
					$scope.success = true;
					Authentication.user = response;
				}, function(response) {
					$scope.error = response.data.message;
				});
			} else {
				$scope.submitted = true;
			}
		};

		// Change user password
		$scope.changeUserPassword = function() {
			$scope.success = $scope.error = null;

			$http.post('/users/password', $scope.passwordDetails).success(function(response) {
				// If successful show success message and clear form
				$scope.success = true;
				$scope.passwordDetails = null;
			}).error(function(response) {
				$scope.error = response.message;
			});
		};
	}
]);
'use strict';

// Users controller
angular.module('users').controller('UsersController', ['$scope', '$stateParams', '$location', 'Authentication', 'Users',
	function($scope, $stateParams, $location, Authentication, Users) {
		$scope.authentication = Authentication;
		$scope.user = {};

		// Create new User
		$scope.create = function() {
			// Create new User object
			var user = new Users ($scope.user);

			// Redirect after save
			user.$save(function(response) {
				$location.path('users/' + response._id);

				// Clear form fields
				$scope.user.firstName = '';
				$scope.user.lastName = '';
				$scope.user.displayName = '';
				$scope.user.email = '';
				$scope.user.username = '';
				$scope.user.password = '';
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Remove existing User
		$scope.remove = function(user) {
			if ( user ) { 
				user.$remove();

				for (var i in $scope.users) {
					if ($scope.users [i] === user) {
						$scope.users.splice(i, 1);
					}
				}
			} else {
				$scope.user.$remove(function() {
					$location.path('users');
				});
			}
		};

		// Update existing User
		$scope.update = function() {
			var user = $scope.user;

			user.$update(function() {
				$location.path('users/' + user._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Users
		$scope.find = function() {
			$scope.users = Users.query();
		};

		// Find existing User
		$scope.findOne = function() {
			$scope.user = Users.get({ 
				userId: $stateParams.userId
			});
		};
	}
]);
'use strict';

// Authentication service for user variables
angular.module('users').factory('Authentication', [
	function() {
		var _this = this;

		_this._data = {
			user: window.user
		};

		return _this._data;
	}
]);
'use strict';

//Users service used to communicate Users REST endpoints
angular.module('users').factory('Users', ['$resource',
	function($resource) {
		return $resource('users/:userId', { userId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);