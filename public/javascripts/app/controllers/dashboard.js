jasonrushControllers.controller('DashboardController', ['$scope', '$http',
  function($scope, $http) {
    ga('send', 'event', 'dashboard', 'view');
    $http.get('/index.json').success(function(data) {
      $scope.blogs = data;
    });
  }]
);