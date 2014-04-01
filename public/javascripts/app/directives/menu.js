jasonrushApp.directive('menu', function() {
  return {
    restrict: 'E',
    templateUrl: '/templates/menu.html',
    controller: ['$scope', '$http', '$routeParams',
      function($scope, $http, $routeParams) {
        $http.get('/blogs/'+$routeParams.blogName+'/menu.json').success(function(data) {
          $scope.recent = data.recent;
          $scope.months = data.months;
          $scope.blog = data.blog;
        });
      }
    ]
  };
});