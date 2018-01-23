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

  update_password();
  $(document).on('click', '.follow-unfollow', function(){
    var id = $(this).data('user-id');
    var url = $(this).data('url');
    handle_follow_user(id, url);
  })
});

function handle_follow_user(id, route) {
  $.ajax({
    url: route,
    type: 'PUT',
    dataType: 'json',
    success: function (data) {
      if(data.type) {
        var html = '';
        if (data.relationships === 'follow') {
          html = '<a class="follow-unfollow btn btn-warning btn-xs btn_handle_follow"' +
            'href="javascript:void(0)" data-user-id="' + id + '" data-url="' + route + '">' +
            I18n.t('users.user.unfollow') +
            '</a>';
          $('.follow_unfollow_' + id).closest('.user-item').find('.ticker-follow-false').removeClass('ticker-follow-false').addClass('ticker-follow-true');
        } else {
          html = '<a class="follow-unfollow btn btn-success btn-xs btn_handle_follow"' +
            'href="javascript:void(0)" data-user-id="' + id + '" data-url="' + route + '">' +
            I18n.t('users.user.follow') +
            '</a>';
          $('.follow_unfollow_' + id).closest('.user-item').find('.ticker-follow-true').removeClass('ticker-follow-true').addClass('ticker-follow-false');
        }

        $('.follow_unfollow_' + id).html(html);
      }
      else if(data.not_login)
        window.location.replace('/users/sign_in');
      else
        sweetAlert(I18n.t('users.index.follow_error'), '', 'error');
    },
    error: function () {
      response([]);
    }
  });
}

function update_password() {
  $('.btn-accept-update-password').click(function(){
    var new_pass = $('#new_password').val();
    var cnf_new_pass = $('#cnf_new_password').val();
    if(new_pass === cnf_new_pass) {
      var current_pass = $('#current_password').val();
      var user_id = $(this).data('id');
      $.ajax({
        url: '/users/' + user_id,
        type: 'PUT',
        dataType: 'json',
        data: {
          current_password: current_pass,
          new_password: new_pass
        },
        success: function (data) {
          if(data.type)
            sweetAlert(I18n.t('success'), data.mess, 'success');
          else if(data.not_login)
            window.location.replace('/users/sign_in');
          else
            sweetAlert(I18n.t('error'), data.mess, 'error');
        },
        error: function () {
          response([]);
        }
      });
    }
    else {
      sweetAlert(I18n.t('error'), I18n.t('profile.update_password.confirm_password_wrong'), 'error');
    }
    $('#new_password').val('');
    $('#cnf_new_password').val('');
    $('#current_password').val('');
  });
}
