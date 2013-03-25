'use strict';

angular.module('fm.filters', [])

/**
 * Returns the player with the following format.
 *
 * {player.name} {player.nickname} {player.created_at | 'dd/MM/yyyy h:mm a'}
 *
 * Dependencies:
 *
 * $filter
 */
.filter('playerDisplay', ['$filter', function($filter) {
    return function(player) {
        var result = "";

        if (angular.isDefined(player)) {
            result = player.name;
            result += " " + player.nickname;

            var dateFormatted = $filter('date').call(this, player.created_at, 'dd/MM/yyyy h:mm a');
            result += " " + dateFormatted.toLowerCase();
        }

        return result;
    };
}]);