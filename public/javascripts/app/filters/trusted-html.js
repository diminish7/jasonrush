jasonrushFilters.filter('trustedHtml', ['$sce',
  function($sce) {
    return function(htmlString) {
      return $sce.trustAsHtml(htmlString);
    };
  }]
);