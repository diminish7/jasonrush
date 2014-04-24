jasonrushApp.directive('newPostLink', function() {
  return {
    restrict: 'E',
    templateUrl: '/templates/new-post-link.html',
    controller: ['$scope', '$routeParams',
      function($scope, $routeParams) {
        $scope.blogName = $routeParams.blogName;
        $scope.$watch(function() { return jasonrushApp.loggedIn; }, function(newVal) { $scope.loggedIn = newVal; });
      }
    ]
  };
});