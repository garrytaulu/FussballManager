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
        return $resource(
            Globals.apiBaseUri + 'api/players/:id'
            , {id: '@id'}
            , {
                'get'   : { method:'GET' },
                'create': { method:'POST' },
                'update': { method:'PUT' },
                'query' : { method:'GET', isArray:true },
                'delete': { method:'DELETE'
            }
        });
    }])

    /**
     * Main service that communicates with the Game API resource.
     *
     * Dependencies:
     *
     * $resource
     */
        .factory('Game', ['$resource', function($resource){
            return $resource(
                Globals.apiBaseUri + 'api/games/:id'
                , {id: '@id'}
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
     * An api utility service with some handy methods for calling the api resources.
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

                successCallback(methodToCall, result);

            }, function(error) {

                console.log(error);

                if (errorCallback) { errorCallback(error); }
            });
        };

        return self;
    }]);
