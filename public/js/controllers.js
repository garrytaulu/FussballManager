'use strict';

function MainCtrl($scope, Player)
{
    $scope.helloWorld = 'Hello from AngularJS';

    Player.query(function(result) {
       console.log(result);
    });
}

MainCtrl.$inject = ['$scope', 'Player'];