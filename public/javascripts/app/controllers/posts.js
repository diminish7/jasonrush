jasonrushControllers.controller('PostsController', ['$scope', '$http', '$routeParams',
  function($scope, $http, $routeParams) {
    ga('send', 'event', 'all posts', 'view', $routeParams.blogName);
    var requestPath;
    if ($routeParams.year && $routeParams.month) {
      requestPath = '/blogs/'+$routeParams.blogName+'/posts.json?year='+$routeParams.year+'&month='+$routeParams.month;
    } else {
      requestPath = '/blogs/'+$routeParams.blogName+'/posts.json';
    }
    $http.get(requestPath).success(function(data) {
      $scope.blog = data.blog;
      $scope.posts = _.map(data.posts, function(post) { post.summaryOrBody = post.summary; return post; });
    });
  }]
);