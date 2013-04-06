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
      * Returns the Team with the following format.
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

    /**
      * Returns the Game with the following format.
      *
      * Blue Team: {game.blueTeam.name} VS Red Team: {game.redTeam.name}
      *
      * Dependencies:
      *
      * $filter
      */
    .filter('gameDisplay', function() {
        return function(game) {
            var result = "";

            if (angular.isDefined(game)) {
                result = "Blue Team: " + game.blueTeam.name + " VS Red Team: " + game.redTeam.name;
            }

            return result;
        };
    })
;