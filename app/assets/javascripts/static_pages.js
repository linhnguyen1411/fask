function vote_panel_move_with_queston() {
  vote_height = $('.vote-panel').height();
  post_height = $('.show-post').height();
  $(window).scroll(function(){
    window_top = $(window).scrollTop();
    if(window_top < (post_height - vote_height)) {
      $(".vote-panel").stop().animate({"marginTop": ($(window).scrollTop()) + "px", "marginLeft":($(window).scrollLeft()) + "px"}, "slow" );
    }
  });
}

$(document).ready(function(){
  vote_panel_move_with_queston();
});
