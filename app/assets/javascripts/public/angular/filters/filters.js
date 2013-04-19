'use strict';

angular.module('fm.filters', [])
    /**
    * Returns the Game with the following format.
    *
    * A: {game.blueAttacker.name} / D: {game.blueDefender.name}
    */
    .filter('gameBlueTeamDisplay', [function() {
        return function(game) {
            var result = "";

            if (angular.isDefined(game)) {
                result = "A: " + game.blueAttacker.name + " / D: " + game.blueDefender.name;
            }

            return result;
        };
    }])

    /**
    * Returns the Game with the following format.
    *
    * A: {game.redAttacker.name} / D: {game.redDefender.name}
    */
    .filter('gameRedTeamDisplay', [function() {
        return function(game) {
            var result = "";

            if (angular.isDefined(game)) {
                result = "A: " + game.redAttacker.name + " / D: " + game.redDefender.name;
            }

            return result;
        };
    }])

/**
 * Returns the score in the following format.
 *
 * {player.nickname} scored for {teamName} team (own goal)
 */
    .filter('scoreDisplay', [function() {
        return function(score) {
            var result = "";

            if (score) {
                // work out which team scored
                var isForBlueTeam = score.player.id == score.game.blueAttacker.id
                        || score.player.id == score.game.blueDefender.id;

                // if it's an own goal then flip the isForBlueTeam flag
                isForBlueTeam = score.own_goal ? !isForBlueTeam : isForBlueTeam;

                score.team = isForBlueTeam ? 'blue' : 'red';

                result = score.player.nickname + " scored for " + score.team + " team";

                if (score.own_goal) {
                    result += " (own goal)";
                }
            }

            return result;
        };
    }])

;