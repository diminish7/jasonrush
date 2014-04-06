jasonrushControllers.controller('admin.LoginController', ['$scope', '$http', '$location',
  function($scope, $http, $location) {
    //// HELPER METHODS //////
    validate = function(user) {
      if (user.email === undefined || user.email.trim() === "" || user.password === undefined || user.password.trim() === "") {
        displayError("Email and password can't be blank.");
        return false;
      } else {
        return true;
      }
    };

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

    //// SETUP ///////
    hideError();
    toggleSubmitting(false);
    $scope.user = {};

    //// AJAX ////////
    $scope.submit = function() {
      if (validate($scope.user)) {
        hideError();
        toggleSubmitting(true);
        data = { user: $scope.user, authenticity_token: AUTH_TOKEN };
        $http.post('/users/sign_in.json', data).success(loginSuccess).error(loginError);
      }
    };

    loginSuccess = function(data) {
      jasonrushApp.loggedIn = true;
      toggleSubmitting(false);
      jasonrushApp.user = data;
      $location.path('/');
    };

    loginError = function(data) {
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