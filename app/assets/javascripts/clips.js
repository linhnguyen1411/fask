function create_clip() {
  $('#btn-create-clip').click(function(){
    var post_id = $(this).data('id');
    var item = this;
    $.ajax({
      url: '/clips',
      type: 'POST',
      dataType: 'json',
      data: {
        post_id: post_id
      },
      success: function (data) {
        if(data.type) {
          $(item).attr('id', 'btn-destroy-clip');
          $(item).html('<i class="fa fa-paperclip" aria-hidden="true"></i> ' + I18n.t('unclip'));
          $(item).unbind();
          destroy_clip()
          $('#post-tile').html($('#post-tile').html() + '<span class="glyphicon glyphicon-pushpin icon-clip"></span>');
        }
        else if(data.not_login)
          window.location.replace('/users/sign_in');
        else
          sweetAlert(I18n.t('error'), I18n.t('clips.create_error'), 'error');
      },
      error: function () {
        sweetAlert(I18n.t('error'), '', 'error');
      }
    });
  });
}

function destroy_clip() {
  $('#btn-destroy-clip').click(function(){
    var post_id = $(this).data('id');
    var item = this;
    $.ajax({
      url: '/clips/' + post_id,
      type: 'DELETE',
      dataType: 'json',
      success: function (data) {
        if(data.type) {
          $(item).attr('id', 'btn-create-clip');
          $(item).html('<i class="fa fa-paperclip" aria-hidden="true"></i> ' + I18n.t('clip'));
          $(item).unbind();
          create_clip();
          $('#post-tile').html($('#post-tile').html().split('<span class="glyphicon glyphicon-pushpin icon-clip"></span>'));
        }
        else if(data.not_login)
          window.location.replace('/users/sign_in');
        else
          sweetAlert(I18n.t('error'), I18n.t('clips.create_error'), 'error');
      },
      error: function () {
        sweetAlert(I18n.t('error'), '', 'error');
      }
    });
  });
}


$(document).ready(function(){
  create_clip();
  destroy_clip();
});
