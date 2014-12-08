jasonrushControllers.controller('PostController', ['$scope', '$http', '$routeParams',
  function($scope, $http, $routeParams) {
    ga('send', 'event', 'post', 'view', $routeParams.blogName, $routeParams.postId);
    url = '/blogs/'+$routeParams.blogName+'/posts/'+$routeParams.postId+'.json';
    config = jasonrushApp.authConfig();
    $http.get(url, config).success(function(data) {
      $scope.blog = data.blog;
      data.post.summaryOrBody = data.post.body;
      $scope.posts = [data.post];
    });
  }]
);