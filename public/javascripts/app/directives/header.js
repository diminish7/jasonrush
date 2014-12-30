jasonrushApp.directive('header', function() {
  return {
    restrict: 'E',
    templateUrl: '/templates/header.html',
    controller: ['$scope', '$routeParams',
      function($scope, $routeParams) {
        if ($routeParams.blogName) {
          $scope.headerImage = "/images/header-straight.png";
          $scope.showSubMenu = true;
        } else {
          $scope.headerImage = "/images/header.png";
          $scope.showSubMenu = false;
        }
      }
    ]
  };
});