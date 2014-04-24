jasonrushControllers.controller('admin.NewPostController', ['$scope', '$http', '$routeParams', '$location',
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
    $scope.hasError = false;
    $scope.post = {};

    $scope.submit = function() {
      toggleSubmitting(true)
      data = { post: $scope.post };
      $http.post('/blogs/'+$routeParams.blogName+'/posts.json', data).success(createPostSuccess).error(createPostError);
    };

    createPostSuccess = function(data) {
      if (data.error === undefined) {
        $location.path('/blogs/'+$routeParams.blogName+'/posts');
      } else {
        displayError(data.error);
      }
      toggleSubmitting(false)
    };

    createPostError = function(data) {
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