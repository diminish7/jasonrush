var jasonrushControllers = angular.module('jasonrushControllers', []);

jasonrushControllers.controller('DashboardController', ['$scope', '$http',
  function($scope, $http) {
    $http.get('/index.json').success(function(data) {
      $scope.blogs = data;
    });
  }]
);