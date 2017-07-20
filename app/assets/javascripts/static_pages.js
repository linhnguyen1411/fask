function image_circle() {
  image_width = parseInt($('.img-circle').css('width').replace('px',''));
  $('.img-circle').css('height', image_width);
  item_width = parseInt($('.img-circle').parents('.item').css('height'));
  if(item_width - 20 > image_width)
    $('.img-circle').parents('.user-avatar').css('padding-top', (item_width - 20 - image_width)/2);
}

$(document).ready(function(){
  image_circle();
  window.onresize = function(event) {
    image_circle();
  };
});
