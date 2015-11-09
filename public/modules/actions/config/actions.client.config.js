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