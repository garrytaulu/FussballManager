'use strict';

angular.module('fm.directives', [])
    .directive('wallCategories',
        function()
        {
            return {
                restrict: 'E',
                require: '?ngModel',
                templateUrl: 'partials/wallCategory.html',
                controller: function ($scope, $element) {
//                    $scope.add = function () {
//                    };
                }
            }
        }
)
;