jasonrushServices.service('PostService', ['$http',
  function($http) {

    this.getList = function(blogName, year, month) {
      var requestPath;
      if (year && month) {
        requestPath = '/blogs/'+blogName+'/posts.json?year='+year+'&month='+month;
      } else {
        requestPath = '/blogs/'+blogName+'/posts.json';
      }
      return $http.get(requestPath, this.headers());
    };

    this.get = function(blogName, postId) {
      var requestPath = '/blogs/'+blogName+'/posts/'+postId+'.json';
      return $http.get(requestPath, this.headers());
    };

    this.put = function(blogName, postId, data) {
      var requestPath = '/blogs/'+blogName+'/posts/'+postId+'.json';
      return $http.put(requestPath, data, this.headers());
    };

    this.post = function(blogName, data) {
      var requestPath = '/blogs/'+blogName+'/posts.json';
      return $http.post(requestPath, data, this.headers());
    };

    this.delete = function(blogName, postId) {
      var requestPath = '/blogs/'+blogName+'/posts/'+postId+'.json';
      return $http.delete(requestPath, this.headers());
    };

    this.headers = function() {
      return jasonrushApp.authConfig();
    };
  }]
);