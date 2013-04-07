'use strict';

angular.module('fm', ['fm.directives', 'fm.filters', 'fm.services']).
    config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider)
    {
        $locationProvider.html5Mode(true);

        $routeProvider.
            when(
            '/',
            {templateUrl: 'partials/home.html', controller: HomeCtrl}
        ).
            when(
                '/players',
                {templateUrl: 'partials/players.html', controller: PlayersCtrl}
            ).
            when(
                '/games',
                {templateUrl: 'partials/games.html', controller: GamesCtrl}
            ).
            when(
                '/games/:gameId',
                {templateUrl: '../partials/gameScores.html', controller: GameDetailCtrl}
            ).
            otherwise({redirectTo: '/'});
    }]);