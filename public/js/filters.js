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
    }])

    /**
      * Returns the player with the following format.
      *
      * {team.name} - Offense: {team.offense.nickname}, Defense: {team.defense.nickname}
      *
      * Dependencies:
      *
      * $filter
      */
    .filter('teamDisplay', function() {
        return function(team) {
            var result = "";

            if (angular.isDefined(team)) {
                result = team.name + " - Offense: " + team.offense.nickname + ", Defense: " + team.defense.nickname;
            }

            return result;
        };
    })
;