'use strict';

function MainCtrl($scope, Player, Team, Game)
{
    $scope.players = [];

    Player.query(function(result) {
        $scope.players = result;
    });

    $scope.teams = [];

//    Team.query(function(result) {
//        $scope.teams = result;
//    });

    $scope.games = [];

    Game.query(function(result) {
        $scope.games = result;
    });
}

MainCtrl.$inject = ['$scope', 'Player', 'Team', 'Game'];

/* *********************** */
/* ** PLAYER *************** */
/* *********************** */
function PlayerDetailCtrl($scope, Player, ApiUtility)
{
    $scope.master = {};
    $scope.playerEdit = null;

    $scope.create = function() {
        $scope.playerEdit = new Player();
    };

    $scope.edit = function(index) {
        $scope.master = $scope.players[index];
        $scope.playerEdit = angular.copy($scope.master);
    };

    $scope.save = function() {
        ApiUtility.upsert($scope.playerEdit, function(type, updatedResource) {
            if (type == 'create') {
                $scope.players.push(updatedResource);
            } else {
                var index = $scope.players.indexOf($scope.master);
                if (index > -1) {
                    $scope.players[index] = updatedResource;
                }
            }

            $scope.cancel();
        });
    };

    $scope.delete = function(index, player) {
        player['$delete'](function() {
            $scope.players.splice(index, 1);
        });
    };

    $scope.cancel = function() {
        $scope.playerEdit = null;
    };
}

PlayerDetailCtrl.$inject = ['$scope', 'Player', 'ApiUtility'];

/* *********************** */
/* ** NAVIGATION ********* */
/* *********************** */
function AppNavigationCtrl($scope)
{

}

AppNavigationCtrl.$inject = ['$scope'];

/* *********************** */
/* ** GAME *************** */
/* *********************** */
function GameDetailCtrl($scope, Player, Game, ApiUtility)
{
    $scope.master = {};
    $scope.gameEdit = null;

    $scope.create = function() {
        Player.query(function(players) {
            $scope.availablePlayers = players;
        });
//        Team.query(function(teams) {
//            $scope.availableTeams = teams;
//        });

        $scope.gameEdit = new Game();
    };

    $scope.edit = function(index) {
        $scope.master = $scope.games[index];
        $scope.gameEdit = angular.copy($scope.master);

        // blueTeam and redTeam are complex objs at this point,
        // however the select control (and the server) require
        // them to be IDs, so we flatten them out here
        $scope.gameEdit.blueAttacker = $scope.gameEdit.blueAttacker.id;
        $scope.gameEdit.blueDefender = $scope.gameEdit.blueDefender.id;
        $scope.gameEdit.redAttacker  = $scope.gameEdit.redAttacker.id;
        $scope.gameEdit.redDefender  = $scope.gameEdit.redDefender.id;

        // Fill in the available players
        Player.query(function(players) {
            $scope.availablePlayers = players;
        });

//        Team.query(function(teams) {
//            $scope.availableTeams = teams;
//        });
    };

    $scope.save = function() {
        ApiUtility.upsert($scope.gameEdit, function(type, updatedResource) {
            if (type == 'create') {
                $scope.games.push(updatedResource);
            } else {
                var index = $scope.games.indexOf($scope.master);
                if (index > -1) {
                    $scope.games[index] = updatedResource;
                }
            }

            $scope.cancel();
        });
    };

    $scope.delete = function(index, game) {
        game['$delete'](function() {
            $scope.games.splice(index, 1);
        });
    };

    $scope.cancel = function() {
        $scope.gameEdit = null;
    };
}

GameDetailCtrl.$inject = ['$scope', 'Player', 'Game', 'ApiUtility'];