'use strict';

function MainCtrl($scope, Player)
{
    $scope.players = [];

    Player.query(function(result) {
        $scope.players = result;
    });
}

MainCtrl.$inject = ['$scope', 'Player'];

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

    $scope.delete = function(player) {
        player['$delete'](function() {
            // TODO: There seems there should be a better way of doing this (more angular-y); i want angular to register that 'player' is now deleted
            var newPlayers = [];

            $scope.players.forEach(function(p) {
                if (p.id != player.id) {
                    newPlayers.push(p);
                }
            });

            $scope.players = newPlayers;
        });
    };

    $scope.cancel = function() {
        $scope.playerEdit = null;
    };
}

PlayerDetailCtrl.$inject = ['$scope', 'Player', 'ApiUtility'];