'use strict';

angular.module('fm', ['fm.directives', 'fm.filters', 'fm.services'])
    .config(['$routeProvider', function($routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: '/partials/home.html',
                controller: HomeCtrl
            })
            .when('/players', {
                    templateUrl: '/partials/players.html',
                    controller: PlayersCtrl
            })
            .when('/games',{
                templateUrl: '/partials/games.html',
                controller: GamesCtrl
            })
            .when(
                '/games/:game', {
                templateUrl: '/partials/gameScores.html',
                controller: GameDetailCtrl
            })
            .otherwise({redirectTo: '/'});
    }]);

var globals = (function()
{
    var me = {};

    me.scoresForGameId = 0;

    return me;
}());