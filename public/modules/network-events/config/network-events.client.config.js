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