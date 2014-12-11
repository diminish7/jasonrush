var jasonrushApp = angular.module('jasonrushApp', [
  'ngRoute',
  'ngSanitize',
  'ui.tinymce',
  'jasonrushControllers',
  'jasonrushFilters',
  'jasonrushServices'
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
        controller: 'admin.PostController'
      }).
      when('/admin/blogs/:blogName/posts/:postId/edit', {
        templateUrl: '/templates/admin/post-form.html',
        controller: 'admin.PostController'
      }).
      otherwise({
        redirectTo: '/'
      });
  }
]);

jasonrushApp.login = function(email, authentication_token) {
  localStorage.setItem('com.jasonrush.email', email);
  localStorage.setItem('com.jasonrush.authentication_token', authentication_token);
};

jasonrushApp.logout = function() {
  localStorage.removeItem('com.jasonrush.email');
  localStorage.removeItem('com.jasonrush.authentication_token');
};

jasonrushApp.loggedIn = function() {
  return localStorage.getItem('com.jasonrush.email') !== null &&
    localStorage.getItem('com.jasonrush.authentication_token') !== null;
};

jasonrushApp.authConfig = function() {
  return {
    headers: {
      'X-User-Email': localStorage.getItem('com.jasonrush.email'),
      'X-User-Token': localStorage.getItem('com.jasonrush.authentication_token')
    }
  };
};

var jasonrushControllers = angular.module('jasonrushControllers', []);
var jasonrushFilters = angular.module('jasonrushFilters', []);
var jasonrushServices = angular.module('jasonrushServices', []);