function injectFn($, html) {
  var priceEl = $('#snsPrice .a-size-large.a-color-price');

  if (priceEl.length == 0) {
    priceEl = $('#priceblock_ourprice');
  }

  if (priceEl.length == 0) {
    priceEl = $('#price');
  }

  if (priceEl.length == 0) {
    priceEl = $('#availability_feature_div');
  }

  if (priceEl.length != 0) {
    priceEl.after(html);
  }
}