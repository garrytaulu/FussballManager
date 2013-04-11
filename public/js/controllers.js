'use strict';

function MainCtrl($scope, $location, Player, Game)
{
    $scope.location = $location;

    $scope.players = [];

    Player.query(function(result) {
        $scope.players = result;
    });

    $scope.games = [];

    Game.query(function(result) {
        $scope.games = result;
    });
}

MainCtrl.$inject = ['$scope', '$location', 'Player', 'Game'];

/* *********************** */
/* ** PLAYER ************* */
/* *********************** */
function PlayersCtrl($scope, Player, ApiUtility)
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

PlayersCtrl.$inject = ['$scope', 'Player', 'ApiUtility'];

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
function GamesCtrl($scope, Player, Game, ApiUtility)
{
    $scope.master = {};
    $scope.gameEdit = null;

    $scope.create = function() {
        Player.query(function(players) {
            $scope.availablePlayers = players;
        });

        $scope.gameEdit = new Game();
    };

    $scope.edit = function(index) {
        $scope.master = $scope.games[index];
        $scope.gameEdit = angular.copy($scope.master);

        // blueAttacker, blueDefender, redAttacker and redDefender are
        // complex objs at this point, however the select control
        // (and the server) require them to be IDs, so we flatten them out here
        $scope.gameEdit.blueAttacker = $scope.gameEdit.blueAttacker.id;
        $scope.gameEdit.blueDefender = $scope.gameEdit.blueDefender.id;
        $scope.gameEdit.redAttacker  = $scope.gameEdit.redAttacker.id;
        $scope.gameEdit.redDefender  = $scope.gameEdit.redDefender.id;

        // Fill in the available players
        Player.query(function(players) {
            $scope.availablePlayers = players;
        });
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
GamesCtrl.$inject = ['$scope', 'Player', 'Game', 'ApiUtility'];

function GameDetailCtrl($scope, $routeParams, Player, Game, Score, ApiUtility)
{
    globals.scoresForGameId = $routeParams.gameId;

    $scope.master      = {};
    $scope.scoreEdit   = null;
    $scope.gameScores  = [];
    $scope.currentGame = null;
    $scope.gamePlayers = [];

    // Fill in the recorded game scores
    Score.query({gameId:globals.scoresForGameId}, function(scores) {
        $scope.gameScores = scores;
    });

    $scope.create = function(playerId, playerName) {
        console.debug('create by playerId');
        $scope.scoreEdit = new Score();
        $scope.scoreEdit.player = playerId;
        $scope.scoreEdit.game   = globals.scoresForGameId;
        $scope.playerName = playerName;
    };

    $scope.edit = function(index) {
        $scope.master = $scope.gameScores[index];
        $scope.scoreEdit = angular.copy($scope.master);

        // Game and Player are complex objects at this point,
        // however the select control (and the server)
        // require them to be IDs, so we flatten them out here
        $scope.scoreEdit.game   = $scope.scoreEdit.game.id;
        $scope.scoreEdit.player = $scope.scoreEdit.player.id;
    };

    $scope.save = function() {
        ApiUtility.upsert($scope.scoreEdit, function(type, updatedResource) {
            if (type == 'create') {
                $scope.gameScores.push(updatedResource);
            } else {
                var index = $scope.gameScores.indexOf($scope.master);
                if (index > -1) {
                    $scope.gameScores[index] = updatedResource;
                }
            }

            $scope.cancel();
        });
    };

    $scope.cancel = function() {
        $scope.scoreEdit = null;
    };

    $scope.getCurrentGame = function() {
        Game.get({id: globals.scoresForGameId}, function (game) {
            $scope.currentGame = game;
        });
    };
    $scope.getCurrentGame();

//    $scope.getGamePlayers = function() {
//        $scope.gamePlayers.push($scope.currentGame.blueAttacker);
//        $scope.gamePlayers.push($scope.currentGame.blueDefender);
//        $scope.gamePlayers.push($scope.currentGame.redAttacker);
//        $scope.gamePlayers.push($scope.currentGame.redDefender);
//    };
//    $scope.getGamePlayers();
}
GameDetailCtrl.$inject = ['$scope', '$routeParams', 'Player', 'Game', 'Score', 'ApiUtility'];

function HomeCtrl($scope)
{
}
HomeCtrl.$inject = ['$scope'];