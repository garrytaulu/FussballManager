'use strict';

angular.module('fm.services', ['ngResource'])

    /**
     * Main service that communicates with the Player API resource.
     *
     * Dependencies:
     *
     * $resource
     */
    .factory('Player', ['$resource', function($resource){
        var self = $resource(
            Globals.apiBaseUri + 'players/:id'
            , {id: '@id'}
            , {
                'get'   : { method:'GET' },
                'create': { method:'POST' },
                'update': { method:'PUT' },
                'query' : { method:'GET', isArray:true },
                'delete': { method:'DELETE' }
            }
        );

        /**
         * Main service that communicates with tallies sub resource of player.
         */
        self.tally = $resource(
            Globals.apiBaseUri + 'players/:id/tallies'
            , {id: '@id'}
            , {
                'get': {
                    method: 'GET', params: {
                        //only: 'param1,param2'
                    }
                }
            }
        );

        return self;
    }])

        /**
         * Main service that communicates with the Game API resource.
         *
         * Dependencies:
         *
         * $resource
         */
        .factory('Game', ['$resource', function($resource){

            var self = $resource(
                Globals.apiBaseUri + 'games/:id'
                , {id: '@id'}
                , {
                    'get'   : { method: 'GET' },
                    'create': { method: 'POST' },
                    'update': { method: 'PUT' },
                    'query' : { method: 'GET', isArray:true },
                    'delete': { method: 'DELETE' }
                }
            );

            /**
             * Main service that communicates with tallies sub resource of game.
             */
            self.tally = $resource(
                Globals.apiBaseUri + 'games/:id/tallies'
                , {id: '@id'}
                , {
                    'get': {
                        method: 'GET', params: {
                            only: 'blueTeamTotal,redTeamTotal'
                        }
                    }
                }
            );

            return self;
        }])

    /**
     * Main service that communicates with the Game/Scores API resource.
     *
     * Dependencies:
     *
     * $resource
     */
    .factory('Score', ['$resource', function($resource){
        return $resource(
            Globals.apiBaseUri + 'games/:game/scores/:id'
            , {game:'@game.id', id: '@id'}
            , {
                'get'   : { method:'GET' },
                'create': { method:'POST' },
                'update': { method:'PUT' },
                'query' : { method:'GET', isArray:true },
                'delete': { method:'DELETE' }
            }
        );
    }])

    /**
     * An api utility service with some handy methods for calling api resources.
     */
    .factory('ApiUtility', [function() {

        var self = {};

        /**
         * Calls the '$create' or '$update' method on the resource parsed based on the resource id.
         * @param resource The resource entity to call the methods on.
         * @param successCallback The success callback to call when the response is successful.
         * @param errorCallback The error callback to call when the response was not successful.
         */
        self.upsert = function (resource, successCallback, errorCallback) {
            var methodToCall = angular.isUndefined(resource.id) || resource.id == 0 ? "create" : "update";

            resource['$' + methodToCall](function(result) {

                if (typeof result != 'undefined' && result != null
                 && typeof result.id != 'undefined' && result.id != null) {
                    resource.id = result.id;
                }

                successCallback(methodToCall);

            }, function(error) {

                console.log(error);

                if (errorCallback) { errorCallback(error); }
            });
        };

        return self;
    }]);
