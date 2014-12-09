jasonrushControllers.controller('PostController', ['$scope', '$routeParams', 'PostService',
  function($scope, $routeParams, PostService) {
    var blogName = $routeParams.blogName;
    var postId = $routeParams.postId;

    ga('send', 'event', 'post', 'view', blogName, postId);

    PostService.get(blogName, postId).success(function(data) {
      $scope.blog = data.blog;
      data.post.summaryOrBody = data.post.body;
      $scope.posts = [data.post];
    });
  }]
);