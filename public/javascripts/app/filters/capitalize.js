jasonrushFilters.filter('capitalize', [
  function() {
    return function(str) {
      if (str === undefined) return str;
      if (str) return str.charAt(0).toUpperCase() + str.substr(1).toLowerCase();
    };
  }]
);