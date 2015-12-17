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