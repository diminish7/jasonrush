jasonrushControllers.controller('admin.PostController', ['$scope', '$routeParams', '$location', 'PostService',
  function($scope, $routeParams, $location, PostService) {
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
      PostService.get($routeParams.blogName, $routeParams.postId).success(function(data) {
        data.post.summaryOrBody = data.post.body;
        $scope.post = data.post;
      });
    } else {
      $scope.post = {};
    }

    $scope.submit = function() {
      toggleSubmitting(true);
      var data;
      if ($scope.post.id) {
        // Update
        data = {
          post: {
            id: $scope.post.id,
            title: $scope.post.title,
            body: $scope.post.body
          }
        }
        PostService.put($routeParams.blogName, $scope.post.id, data).
          success(submitSuccess).
          error(submitError);
      } else {
        // Create
        data = { post: $scope.post };
        PostService.post($routeParams.blogName, data).success(submitSuccess).error(submitError);
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