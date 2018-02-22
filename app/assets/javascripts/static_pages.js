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

function active_topic() {
  function remove_class_active(){
    $('#link-topic-1').removeClass('topic-active');
    $('#link-topic-2').removeClass('topic-active');
    $('#link-topic-3').removeClass('topic-active');
  }
  var topic_id = $('#current-toppic').data('id');
  if (topic_id === 1) {
    remove_class_active();
    $('#link-topic-1').addClass('topic-active');
  }
  else if (topic_id === 2) {
    remove_class_active();
    $('#link-topic-2').addClass('topic-active');
  }
  else if (topic_id === 3) {
    remove_class_active();
    $('#link-topic-3').addClass('topic-active');
  }
}
function hide_flash(){
 $('.alert').animate({top: '50px'}, 300, function() {
    window.setTimeout(function() {
      $('.alert').animate({top: '-50px'}, 300, function() {
        $('.alert').hide();
      });
    }, 4000);
  });
}

$(document).ready(function(){
  vote_panel_move_with_queston();
  active_topic();
  hide_flash();
});
