jasonrushControllers.controller('PostsController', ['$scope', '$http', '$routeParams',
  function($scope, $http, $routeParams) {
    var requestPath;
    if ($routeParams.year && $routeParams.month) {
      requestPath = '/blogs/'+$routeParams.blogName+'/posts.json?year='+$routeParams.year+'&month='+$routeParams.month;
    } else {
      requestPath = '/blogs/'+$routeParams.blogName+'/posts.json';
    }
    $http.get(requestPath).success(function(data) {
      $scope.blog = data.blog;
      $scope.posts = data.posts;
    });
  }]
);