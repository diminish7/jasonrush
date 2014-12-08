jasonrushControllers.controller('admin.PostController', ['$scope', '$http', '$routeParams', '$location',
  function($scope, $http, $routeParams, $location) {
    ///// HELPERS //////
    hideError = function() {
      $scope.hasError = false;
      $scope.errorMessage = "";
    };

    displayError = function(msg) {
      $scope.hasError = true;
      $scope.errorMessage = msg;
    };

    toggleSubmitting = function(isSubmitting) {
      $scope.submitting = isSubmitting;
    }

    //// INIT //////
    toggleSubmitting(false);
    hideError();
    if ($routeParams.postId) {
      $http.get('/blogs/'+$routeParams.blogName+'/posts/'+$routeParams.postId+'.json').success(function(data) {
        data.post.summaryOrBody = data.post.body;
        $scope.post = data.post;
      });
    } else {
      $scope.post = {};
    }

    $scope.submit = function() {
      toggleSubmitting(true);
      config = jasonrushApp.authConfig();
      if ($scope.post.id) {
        // Update
        url = '/blogs/'+$routeParams.blogName+'/posts/' + $scope.post.id + '.json';
        data = {
          post: {
            id: $scope.post.id,
            title: $scope.post.title,
            body: $scope.post.body
          }
        }
        $http.put(url, data, config).success(submitSuccess).error(submitError);
      } else {
        // Create
        url = '/blogs/'+$routeParams.blogName+'/posts.json';
        data = { post: $scope.post };
        $http.post(url, data, config).success(submitSuccess).error(submitError);
      }
    };

    submitSuccess = function(data) {
      if (data.error === undefined) {
        $location.path('/blogs/'+$routeParams.blogName+'/posts');
      } else {
        displayError(data.error);
      }
      toggleSubmitting(false)
    };

    submitError = function(data) {
      var error;
      if (typeof data === 'string') {
        error = (data.trim() === "") ? UNKNOWN_ERROR : data;
      } else if (data.error === undefined && data.error.trim() === "") {
        error = UNKNOWN_ERROR;
      } else {
        error = data.error;
      }
      displayError(error);
      toggleSubmitting(false);
    };
  }]
);