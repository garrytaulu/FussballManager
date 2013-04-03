'use strict';

function MainCtrl($scope, Player, Team)
{
    $scope.players = [];

    Player.query(function(result) {
        $scope.players = result;
    });

    $scope.teams = [];

    Team.query(function(result) {
        $scope.teams = result;
    });
}

MainCtrl.$inject = ['$scope', 'Player', 'Team'];

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

function TeamDetailCtrl($scope, Team, Player, ApiUtility)
{
    $scope.master = {};
    $scope.teamEdit = null;

    $scope.create = function() {
        Player.query(function(players) {
            $scope.availablePlayers = players;
        });

        $scope.teamEdit = new Team();
    };

    $scope.edit = function(index) {
        $scope.master = $scope.teams[index];
        $scope.teamEdit = angular.copy($scope.master);

        // offense and defense are complex objs at this point,
        // however the select control (and the server) require
        // them to be IDs, so we flatten them out here
        $scope.teamEdit.offense = $scope.teamEdit.offense.id;
        $scope.teamEdit.defense = $scope.teamEdit.defense.id;

        // Fill in the available players
        Player.query(function(players) {
            $scope.availablePlayers = players;
        });
    };

    $scope.save = function() {
        ApiUtility.upsert($scope.teamEdit, function(type, updatedResource) {
            if (type == 'create') {
                $scope.teams.push(updatedResource);
            } else {
                var index = $scope.teams.indexOf($scope.master);
                if (index > -1) {
                    $scope.teams[index] = updatedResource;
                }
            }

            $scope.cancel();
        });
    };

    $scope.delete = function(index, team) {
        team['$delete'](function() {
            $scope.teams.splice(index, 1);
        });
    };

    $scope.cancel = function() {
        $scope.teamEdit = null;
    };
}

TeamDetailCtrl.$inject = ['$scope', 'Team', 'Player', 'ApiUtility'];