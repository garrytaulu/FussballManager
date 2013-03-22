'use strict';

angular.module('fm.services', ['ngResource'])
    .factory('Player', ['$resource', function($resource){
//        return $resource('http://fussball-manager.herokuapp.com/api/players/:id', {id: '@id'}, {
        return $resource('http://localhost\\:3000/api/players/:id', {id: '@id'}, {
            'get'   : {method:'GET'},
            'create': {method:'POST'},
            'update': {method:'PUT'},
            'query' : {method:'GET', isArray:true},
            'delete': {method:'DELETE'}
        })
    }])
;

