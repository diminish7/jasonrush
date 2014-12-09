jasonrushControllers.controller('PostsController', ['$scope', '$routeParams', 'PostService',
  function($scope, $routeParams, PostService) {
    var blogName = $routeParams.blogName;
    var year = $routeParams.year;
    var month = $routeParams.month;

    ga('send', 'event', 'all posts', 'view', $routeParams.blogName);

    PostService.getList(blogName, year, month).success(function(data) {
      $scope.blog = data.blog;
      $scope.posts = _.map(data.posts, function(post) {
        post.summaryOrBody = post.summary;
        return post;
      });
    });
  }]
);