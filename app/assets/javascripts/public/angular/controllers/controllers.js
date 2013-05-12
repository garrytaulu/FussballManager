'use strict';

function MainCtrl($scope, Player, Game) {
    $scope.players = [];
    $scope.games = [];

    $scope.fameCategories  = [];
    $scope.shameCategories = [];

} MainCtrl.$inject = ['$scope', 'Player', 'Game'];

/**
 * Controller is mapped to route: /players
 */
function PlayersCtrl($scope, Player, ApiUtility) {

    $scope.master = {};
    $scope.playerEdit = null;

    Player.query(function(result) {
        $scope.players = result;
    });

    $scope.create = function() {
        $scope.playerEdit = new Player();
    };

    $scope.edit = function(index) {
        $scope.master = $scope.players[index];
        $scope.playerEdit = angular.copy($scope.master);
    };

    $scope.save = function() {
        var player = angular.copy($scope.playerEdit);
        ApiUtility.upsert(player, function(type) {
            if (type == 'create') {
                $scope.players.push(player);
            } else {
                var index = $scope.players.indexOf($scope.master);
                if (index > -1) {
                    $scope.players[index] = player;
                }
            }

            $scope.cancel();
        });
    };

    $scope.delete = function(index, player) {
        player.$delete(function() {
            $scope.players.splice(index, 1);
        });
    };

    $scope.cancel = function() {
        $scope.playerEdit = null;
    };

} PlayersCtrl.$inject = ['$scope', 'Player', 'ApiUtility'];

/* *********************** */
/* ** NAVIGATION ********* */
/* *********************** */
function AppNavigationCtrl($scope) {
    $scope.menuItems = [
        {label:'Home', href:'#/home', iconClass:'icon-home', isActive:true},
        {label:'Games', href:'#/games', iconClass:'icon-bell', isActive:false},
        {label:'Players', href:'#/players', iconClass:'icon-user', isActive:false}
    ];

    $scope.currentActiveIndex = 0;

    $scope.updateMenu = function(index) {
        $scope.menuItems[$scope.currentActiveIndex].isActive = false;
        $scope.menuItems[index].isActive = true;
        $scope.currentActiveIndex = index;
    };
} AppNavigationCtrl.$inject = ['$scope'];

/**
 * Controller is mapped to route: /games
 */
function GamesCtrl($scope, Player, Game, ApiUtility) {

    $scope.master = {};
    $scope.gameEdit = null;

    Game.query(function(result) {
        $scope.games = result;
    });

    // Fill in the available players
    Player.query(function(players) {
        $scope.availablePlayers = players;
    });

    $scope.create = function() {
        $scope.gameEdit = new Game({status:'created'});
    };

    $scope.edit = function(index) {
        $scope.master = $scope.games[index];
        $scope.gameEdit = angular.copy($scope.master);

        // update the player references to reference players in the availablePlayers list.
        for (var i = 0; i < $scope.availablePlayers.length;i++) {
            switch($scope.availablePlayers[i].id) {
                case $scope.gameEdit.blueAttacker.id:
                    $scope.gameEdit.blueAttacker = $scope.availablePlayers[i];
                    break;
                case $scope.gameEdit.redAttacker.id:
                    $scope.gameEdit.redAttacker = $scope.availablePlayers[i];
                    break;
                case $scope.gameEdit.blueDefender.id:
                    $scope.gameEdit.blueDefender = $scope.availablePlayers[i];
                    break;
                case $scope.gameEdit.redDefender.id:
                    $scope.gameEdit.redDefender = $scope.availablePlayers[i];
                    break;
            }
        }
    };

    $scope.save = function() {
        var game = angular.copy($scope.gameEdit);
        ApiUtility.upsert(game, function(type) {
            if (type == 'create') {
                $scope.games.push(game);
            } else {
                var index = $scope.games.indexOf($scope.master);
                if (index > -1) {
                    $scope.games[index] = game;
                }
            }

            $scope.cancel();
        });
    };

    $scope.delete = function(index, game) {
        game.$delete(function() {
            $scope.games.splice(index, 1);
        });
    };

    $scope.cancel = function() {
        $scope.gameEdit = null;
    };

} GamesCtrl.$inject = ['$scope', 'Player', 'Game', 'ApiUtility'];

/**
 * Controller is mapped to route: /games/:game
 */
function GameDetailCtrl($scope, $routeParams, Game, Score, ApiUtility) {

    $scope.master      = {};
    $scope.scoreEdit   = null;
    $scope.gameScores  = [];
    $scope.game        = null;
    $scope.gamePlayers = [];

    // get the selected game
    Game.get({id: $routeParams.game}, function(game) {
        $scope.game = game;
    });

    // Fill in the recorded game scores
    Score.query({game:$routeParams.game}, function(scores) {
        $scope.gameScores = scores;
    });

    $scope.create = function(player) {
        $scope.scoreEdit = new Score({
            game: $scope.game,
            player: player,
            own_goal: false
        });
    };

    $scope.edit = function(index) {
        $scope.master = $scope.gameScores[index];
        $scope.scoreEdit = angular.copy($scope.master);
    };

    $scope.save = function() {
        var score = angular.copy($scope.scoreEdit);
        ApiUtility.upsert(score, function(type) {
            if (type == 'create') {
                $scope.gameScores.push(score);
                $scope.game = score.game;
                $scope.updateGame();
            } else {
                var index = $scope.gameScores.indexOf($scope.master);
                if (index > -1) {
                    $scope.gameScores[index] = score;
                    $scope.game = score.game;
                    $scope.updateGame();
                }
            }

            $scope.cancel();
        });
    };

    $scope.cancel = function() {
        $scope.scoreEdit = null;
    };

    $scope.changeToStatus = function(newStatus) {
        var game = angular.copy($scope.game);

        game.status = newStatus;
        ApiUtility.upsert(game, function() {
            $scope.updateGame();
        });
    };

    $scope.updateGame = function() {
        // get the selected game
        Game.get({id: $routeParams.game}, function(game) {
            $scope.game = game;
        });

//        $scope.updateGames($scope.game);
    }


} GameDetailCtrl.$inject = ['$scope', '$routeParams', 'Game', 'Score', 'ApiUtility'];

function HomeCtrl($scope, Wall) {
    Wall.query(function(result) {
        var wallFameCategories  = [];
        var wallShameCategories = [];
        result.forEach(function(elem, index)
        {
//            debugger;
            if (elem.categoryType=='FAME'){
                wallFameCategories[wallFameCategories.length] = elem;
            } else if (elem.categoryType=='SHAME') {
                wallShameCategories[wallShameCategories.length] = elem;
            }
        });
        $scope.fameCategories  = wallFameCategories;
        $scope.shameCategories = wallShameCategories;
    });
} HomeCtrl.$inject = ['$scope', 'Wall'];