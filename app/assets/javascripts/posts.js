function load_choose_toppic() {
  var value = $('#select-toppic').val();
  var check_user_login = $('#check_user_login').val();
  if(value === '1') {
    $('#select-location').closest('.form-group').hide('500');
    $('#topic-info').html( I18n.t('posts.new.qa_info'));
    if(check_user_login === 'true') {
      $('.panel-info-user').hide('500');
      $('.form-login').find('#user_email').removeAttr('required');
      $('.form-login').find('#user_password').removeAttr('required');
    }
    else {
      $('.panel-info-user').show('500');
      $('#anonymous').closest('label').hide('500');
      $('.form-login').show('500');
      $('.form-login').find('#user_email').attr('required', true);
      $('.form-login').find('#user_password').attr('required', true);
    }
  }
  else if (value === '2') {
    $('#select-location').closest('.form-group').show('500');
    $('#topic-info').html( I18n.t('posts.new.feedback_info'));
    if(check_user_login === 'true') {
      $('.panel-info-user').show('500');
      $('.form-login').hide('500');
      $('.form-login').find('#user_email').removeAttr('required');
      $('.form-login').find('#user_password').removeAttr('required');
      $('#anonymous').closest('label').show('500');
    }
    else {
      $('.panel-info-user').show('500');
      $('#anonymous').closest('label').show('500');
      $('.form-login').show('500');
      $('.form-login').find('#user_email').attr('required', true);
      $('.form-login').find('#user_password').attr('required', true);
    }
  }
  else if (value === '3') {
    $('#topic-info').html(I18n.t('posts.new.confession_info'));
    $('#select-location').closest('.form-group').hide('500');
    $('.panel-info-user').hide('500');
    $('.form-login').find('#user_email').removeAttr('required');
    $('.form-login').find('#user_password').removeAttr('required');
  }
}

function load_form_login_when_post(item) {
  var check_user_login = $('#check_user_login').val();
  if(check_user_login !== 'true') {
    var value = $(item).is(':checked');
    if(value) {
      $(item).closest('.box-panel').find('.form-login').hide('500')
      $('.form-login').find('#user_email').removeAttr('required');
      $('.form-login').find('#user_password').removeAttr('required');
    }
    else {
      $(item).closest('.box-panel').find('.form-login').show('500')
      $('.form-login').find('#user_email').attr('required', true);
      $('.form-login').find('#user_password').attr('required', true);
    }
  }
}

function load_tag_user_of_post() {
  $('.tag-user-item').each(function(){
    if($(this).find('.fa').length == 0) {
      html = $(this).html();
      html = '<i class="fa fa-address-book-o" aria-hidden="true"></i>' + html
      $(this).html(html);
    }
  });
}

function move_panel_vote() {
  $(window).scroll(function(){
    if ($(window).scrollTop() < ($('#post-body').height() - $('.vote-of-post').height())) {
      $('.vote-of-post').stop().animate({'marginTop': ($(window).scrollTop()) + 'px'}, 'slow' );
    }
  });
}

function reaction_vote_post() {
  $('.btn-loggin-continue').click(function(){
    swal({
      title: I18n.t('error'),
      text: I18n.t('login_to_continue'),
      type: 'error',
      showCancelButton: true,
      cancelButtonText: I18n.t('cancel'),
      confirmButtonColor: '#DD6B55',
      confirmButtonText: I18n.t('ok'),
      closeOnConfirm: false
    },
    function(){
      window.location.href = '/users/sign_in';
    });
  });

  $('.btn-vote').click(function(){
    var type = $(this).data('type');
    var model = $(this).data('model');
    var id = $(this).data('id');
    var lct = this;
    if(typeof(type) === 'undefined' || typeof(model) === 'undefined' || typeof(id) === 'undefined')
      sweetAlert(I18n.t('reactions.create.error'), '', 'error');
    else {
      $.ajax({
        url: '/reactions',
        type: 'POST',
        dataType: 'json',
        data: {
          type: type,
          model: model,
          item_id: id
        },
        success: function (data) {
          if(data.type === 'success') {
            if(model === 'Post') {
              $('.point-vote').html('').toggle(200);
              $('.point-vote').html(data.data).toggle(200);
            }
            else {
              var data = data.data;
              $(lct).closest('div').find('.count-like').html('' + data[0] + '');
              $(lct).closest('div').find('.count-dislike').html('' + data[1] + '');
              $(lct).closest('div').find('.count-heart').html('' + data[2] + '');
            }
          }
          else
            sweetAlert(I18n.t('reactions.create.error'), '', 'error');
        },
        error: function () {
          response([]);
        }
      });
    }
  });
}

function add_new_comment() {
  $('#add-new-comment').click(function(){
    if ($(this).attr('is_login') === 'true') {
      $(this).css('display','none');
      $('.comment-new').show('500');
    }
    else {
      swal({
        title: I18n.t('warning'),
        text: I18n.t('login_to_continue'),
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#DD6B55',
        confirmButtonText: I18n.t('ok'),
        cancelButtonText: I18n.t('cancel'),
        closeOnConfirm: false
      },
      function(){
        window.location.replace('/users/sign_in');
      });
    }
  });
}

$(document).ready(function(){
  add_new_comment();
  load_choose_toppic();
  load_tag_user_of_post();
  move_panel_vote();
  reaction_vote_post();

  $('#select-toppic').change(function(){
    load_choose_toppic();
  });

  $('#anonymous').change(function(){
    load_form_login_when_post(this);
  });
});
