function getCategory($) {
  // Breadcrumb categories at top of PDP
  var categories = $('#wayfinding-breadcrumbs_container ul a').map(function(idx, el) {
    return $(el).text().trim();
  }).get();

  // First fallback to Best Sellers Rank section
  if (categories.length == 0 || categories[0].indexOf('Back to search results') != -1) {
    $('#productDetails_detailBullets_sections1 tbody tr').each(function(i, obj) {
      if( $(obj).find('th').text().trim() == "Best Sellers Rank" ) {
        console.log("Fallback to Best Sellers");
        categories = $(obj).find('td a').map(function(idx, el) {
          if ( $(el).text().trim().indexOf('See Top') != -1 ) {
            return null;
          }
          return $(el).text().trim();
        }).get().filter(Boolean);
      }
      //test
    });
  }

  // Fallback to sales rank in product details
  if (categories.length == 0 || categories[0].indexOf('Back to search results') != -1) {
    console.log("Fallback to SalesRank");
    categories = $('#SalesRank .zg_hrsr_item:first-child .zg_hrsr_ladder a').map(function(idx, el) {
      return $(el).text().trim();
    }).get();
  }

  return categories;
}

function getExternalId($) {
  return $('#buybox #ASIN').val();
}