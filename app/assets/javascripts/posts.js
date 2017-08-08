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

$(document).ready(function(){
  load_choose_toppic();
  load_tag_user_of_post();

  $('#select-toppic').change(function(){
    load_choose_toppic();
  });

  $('#anonymous').change(function(){
    load_form_login_when_post(this);
  });
});
