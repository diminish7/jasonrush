var jasonrushApp = angular.module('jasonrushApp', [
  'ngRoute',
  'ngSanitize',
  'jasonrushControllers',
  'jasonrushFilters'
]);

jasonrushApp.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: '/templates/dashboard.html',
        controller: 'DashboardController'
      }).
      when('/blogs/:blogName/posts', {
        templateUrl: '/templates/posts.html',
        controller: 'PostsController'
      }).
      when('/blogs/:blogName/posts/year/:year/month/:month', {
        templateUrl: '/templates/posts.html',
        controller: 'PostsController'
      }).
      when('/blogs/:blogName/posts/:postId', {
        templateUrl: '/templates/posts.html',
        controller: 'PostController'
      }).
      when('/blogs/:blogName/menu', {
        templateUrl: '/templates/menu-container.html',
        controller: 'MenuController'
      }).
      when('/admin/login', {
        templateUrl: '/templates/admin/login.html',
        controller: 'admin.LoginController'
      }).
      when('/admin/blogs/:blogName/posts/new', {
        templateUrl: '/templates/admin/post-form.html',
        controller: 'admin.NewPostController'
      }).
      otherwise({
        redirectTo: '/'
      });
  }
]);

jasonrushApp.config(['$httpProvider',
  function($httpProvider) {
    $httpProvider.defaults.headers.post['X-CSRF-Token'] = AUTH_TOKEN;
    $httpProvider.defaults.headers.put['X-CSRF-Token'] = AUTH_TOKEN;
  }
]);

var jasonrushControllers = angular.module('jasonrushControllers', []);
var jasonrushFilters = angular.module('jasonrushFilters', []);