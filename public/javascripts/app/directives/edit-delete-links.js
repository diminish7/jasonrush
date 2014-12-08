jasonrushApp.directive('editDeleteLinks', function() {
  return {
    restrict: 'E',
    scope: {
      post: '=',
      posts: '='
    },
    templateUrl: '/templates/edit-delete-links.html',
    controller: ['$scope', '$http', '$location', '$routeParams',
      function($scope, $http, $location, $routeParams) {
        $scope.blogName = $routeParams.blogName;
        $scope.$watch(function() { return jasonrushApp.loggedIn(); }, function(newVal) { $scope.loggedIn = newVal; });

        $scope.deletePost = function(post) {
          url = '/blogs/'+$routeParams.blogName+'/posts/' + $scope.post.id + '.json';
          config = jasonrushApp.authConfig();
          $http.delete(url, config).success(deleteSuccess).error(deleteError);
        };

        deleteSuccess = function(data) {
          if (data.error === undefined) {
            _.each($scope.posts, function(p) { if(p.id == data.id) p.isDeleted = true; });
            $location.path('/blogs/'+$routeParams.blogName+'/posts');
          } else {
            alert(data.error);
          }
        };

        deleteError = function(data) {
          var error;
          if (typeof data === 'string') {
            error = (data.trim() === "") ? UNKNOWN_ERROR : data;
          } else if (data.error === undefined && data.error.trim() === "") {
            error = UNKNOWN_ERROR;
          } else {
            error = data.error;
          }
          alert(error);
        };
      }
    ]
  };
});