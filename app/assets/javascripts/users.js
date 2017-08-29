function load_user_avatar(input, klass) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('.' + klass).attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
};

$(document).ready(function(){
  $('.upload-user-avatar').on('change', function() {
    load_user_avatar(this, 'img-upload');
  });
});

function handle_follow_user(id, route) {
  $.ajax({
    url: route,
    type: 'PUT',
    dataType: 'json',
    success: function (data) {
      if(data.type === 'success') {
        var html = '';
        var onClickFun = 'onclick=handle_follow_user("' + id + '","' + route + '")';

        if (data.relationships === 'follow') {
          html = '<a class="btn btn-success btn-xs btn_handle_follow"' +
            'href="javascript:void(0)"' + onClickFun + '>' +
            I18n.t('users.user.following') +
            '</a>';
        } else {
          html = '<a class="btn btn-default btn-xs btn_handle_follow"' +
            'href="javascript:void(0)"' + onClickFun + '>' +
            I18n.t('users.user.follow') +
            '</a>';
        }

        $('.follow_unfollow_' + id).html(html);
      }
      else {
        sweetAlert(I18n.t('users.index.follow_error'), '', 'error');
      }
    },
    error: function () {
      response([]);
    }
  });
}
