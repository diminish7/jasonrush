jasonrushControllers.controller('MenuController', ['$scope', '$http', '$routeParams',
  function($scope, $http, $routeParams) {
    ga('send', 'event', 'menu', 'view', $routeParams.blogName);
  }]
);