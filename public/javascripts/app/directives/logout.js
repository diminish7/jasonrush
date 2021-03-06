jasonrushApp.directive('logout', function() {
  return {
    restrict: 'E',
    templateUrl: '/templates/logout.html',
    controller: ['$scope', '$http',
      function($scope, $http) {
        $scope.$watch(function() { return jasonrushApp.loggedIn(); }, function(newVal) { $scope.loggedIn = newVal; });
        $scope.logout = function() {
          $http.delete('/users/sign_out.json').success(function() {
            jasonrushApp.logout();
          });
        };
      }
    ]
  };
});