var jasonrushApp = angular.module('jasonrushApp', [
  'ngRoute',
  'jasonrushControllers'
]);

jasonrushApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'templates/dashboard.html',
        controller: 'DashboardController'
      }).
      otherwise({
        redirectTo: '/'
      });
  }
]);