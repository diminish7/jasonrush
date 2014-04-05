jasonrushControllers.controller('PostController', ['$scope', '$http', '$routeParams',
  function($scope, $http, $routeParams) {
    ga('send', 'event', 'post', 'view', $routeParams.blogName, $routeParams.postId);
    $http.get('/blogs/'+$routeParams.blogName+'/posts/'+$routeParams.postId+'.json').success(function(data) {
      $scope.blog = data.blog;
      data.post.summaryOrBody = data.post.body;
      $scope.posts = [data.post];
    });
  }]
);