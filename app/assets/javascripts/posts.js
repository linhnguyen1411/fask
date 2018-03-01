var swal_color = '#DD6B55';
function load_choose_toppic() {
  var value = $('#select-toppic').val();
  var check_user_login = $('#check_user_login').val();
  if(value === '1') {
    $('#select-location').closest('.form-group').hide('500');
    $('#select-category').closest('.form-group').hide('500');
    $('#posts-tag').show('500');
    $('#topic-info').html( I18n.t('posts.new.qa_info'));
    $('#anonymous').hide('500');
    if(check_user_login === 'true') {
      $('.panel-info-user').hide('500');
      $('.form-login').find('#user_email').removeAttr('required');
      $('.form-login').find('#user_password').removeAttr('required');
    }
    else {
      $('.panel-info-user').show('500');
      $('#anonymous').hide('500');
      $('.form-login').show('500');
      $('.form-login').find('#user_email').attr('required', true);
      $('.form-login').find('#user_password').attr('required', true);
    }
  }
  else if (value === '2') {
    $('#posts-tag').hide('500');
    $('#select-location').closest('.form-group').show('500');
    $('#select-category').closest('.form-group').show('500');
    $('#topic-info').html( I18n.t('posts.new.feedback_info'));
    if(check_user_login === 'true') {
      $('.panel-info-user').show('500');
      $('.form-login').hide('500');
      $('.form-login').find('#user_email').removeAttr('required');
      $('.form-login').find('#user_password').removeAttr('required');
      $('#anonymous').show('500');
    }
    else {
      $('.panel-info-user').show('500');
      $('#anonymous').show('500');
      $('.form-login').show('500');
      $('.form-login').find('#user_email').attr('required', true);
      $('.form-login').find('#user_password').attr('required', true);
    }
  }
  else if (value === '3') {
    $('#posts-tag').show('500');
    $('#topic-info').html(I18n.t('posts.new.confession_info'));
    $('#select-location').closest('.form-group').hide('500');
    $('#anonymous').hide('500');
    $('#select-category').closest('.form-group').hide('500');
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
      confirmButtonColor: swal_color,
      confirmButtonText: I18n.t('ok'),
      closeOnConfirm: false
    },
    function(){
      window.location.href = '/users/sign_in';
    });
  });
  $(document).on('click','.btn-vote',function(){
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
          var reactions = data.reaction_type;
          if(data.type) {
            if(model === 'Post') {
              $('.point-vote-'+ data.id).html('').toggle(200);
              $('.point-vote-'+ data.id).html(data.data).toggle(200);
            }
            else {
              var data = data.data;
              $(lct).closest('.reactions-form').find('.count-like').html('' + data[0] + '');
              $(lct).closest('.reactions-form').find('.count-dislike').html('' + data[1] + '');
              $(lct).closest('.reactions-form').find('.count-heart').html('' + data[2] + '');
              var target_link = $(lct).closest('.reactions-form').find('.link-reaction');
              if (reactions === "dislike"){
                if(data[0] + data[2] == 0 )
                  target_link.html('');
                else
                  target_link.html(data[0] + data[2] + ' ' + I18n.t('reactions.another_people'));
              }
              else{
                if (data[0] + data[2] == 1) {
                  target_link.html(I18n.t('reactions.you_like'));
                }
                else
                  target_link.html(I18n.t('reactions.you_and') + (data[0] + data[2] - 1) + ' ' + I18n.t('reactions.another_people'));
              }
            }
          }
          else if(data.not_login)
            window.location.replace('/users/sign_in');
          else if(data.not_authorized){
            notify_not_authorized();
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
  $('.add-new-comment').click(function(){
    if ($(this).attr('is_login') === 'true') {
      $(this).css('display','none');
      $(this).closest('.form-new-commment').find('.editable').show('500');
      $(this).closest('.form-new-commment').find('.comment-new').show('500');
    }
    else {
      swal({
        title: I18n.t('warning'),
        text: I18n.t('login_to_continue'),
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: swal_color,
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

function correct_answer() {
  $('.correct-answer').click(function(){
    var item = this;
    var answer_id = $(this).data('id')
    $.ajax({
      url: '/answers/' + answer_id + '/edit',
      type: 'GET',
      dataType: 'json',
      data: {},
      success: function (data) {
        if(data.type) {
          $(item).hide('300');
          var html = '<div class="ribbon base"><span>'+ I18n.t('posts.answer.correct_answer') +'</span></div>';
          $(item).closest('.ribbon-content').find('.best-answer').html(html);
        }
        else if(data.not_login)
          window.location.replace('/users/sign_in');
        else if(data.not_authorized){
          notify_not_authorized();
        }
        else
          sweetAlert(I18n.t('reactions.create.error'), '', 'error');
      },
      error: function () {
        response([]);
      }
    });
  });
}

function load_modal_edit_comment() {
  $('.btn-edit-comment').click(function(){
    $('#edit-comment-editable').attr('data-id', $(this).data('id'));
    $('#edit-comment-editable').html($(this).closest('.item-body').find('.content').html());
  });
}

function appcept_edit_comment() {
  $('.btn-accept-edit-comment').click(function(){
    var content = $('#edit-comment-editable').html();
    var id = $('#edit-comment-editable').attr('data-id');
    if ($('#edit-comment-editable').text().length == 0) {
      $('.editable').css('border','2px solid red');
      setTimeout(function(){
        $('.editable').css('border', '');
      }, 500);
    }else{
      $.ajax({
        url: '/comments/' + id,
        type: 'PATCH',
        dataType: 'json',
        data: {
          content: content
        },
        success: function (data) {
          if (data.type) {
            $('.comment-item-' + id).find('.content').hide();
            $('.comment-item-' + id).find('.content').html(data.content);
            $('.comment-item-' + id).find('.content').show('500');
            $('#modal-edit-comment').modal('hide');
          }
          else if(data.not_login)
            window.location.replace('/users/sign_in');
          else if(data.not_authorized){
            notify_not_authorized();
          }
          else
            sweetAlert(I18n.t('reactions.create.error'), '', 'error');
        },
        error: function () {}
      });
    }
  });
}

function delete_answer() {
  $('.btn-delete-answer').click(function(){
    var id = $(this).data('id');
    swal({
      title: I18n.t('warning'),
      text: I18n.t('answers.destroy.are_you_sure'),
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: swal_color,
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: false
    },
    function(){
      $.ajax({
        url: '/answers/' + id,
        type: 'DELETE',
        dataType: 'json',
        data: {},
        success: function (data) {
          if (data.type) {
            sweetAlert(I18n.t('reactions.create.success'), '', 'success');
            $('.comment-item-' + id).hide('500')
            setTimeout(function(){$('.answer-' + id).remove();}, 700);
          }
          else if(data.not_login)
            window.location.replace('/users/sign_in');
          else if(data.not_authorized){
            notify_not_authorized();
          }
          else
            sweetAlert(I18n.t('reactions.create.error'), '', 'error');
        },
        error: function () {}
      });
    });
  });
}

function delete_comment() {
  $('.btn-delete-comment').click(function(){
    var id = $(this).data('id');
    swal({
      title: I18n.t('warning'),
      text: I18n.t('posts.destroy.are_you_sure'),
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: swal_color,
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: false
    },
    function(){
      $.ajax({
        url: '/comments/' + id,
        type: 'DELETE',
        dataType: 'json',
        data: {},
        success: function (data) {
          if (data.type) {
            sweetAlert(I18n.t('reactions.create.success'), '', 'success');
            $('.comment-item-' + id).hide('500')
            setTimeout(function(){$('.comment-item-' + id).remove();}, 700);
          }
          else if(data.not_login)
            window.location.replace('/users/sign_in');
          else if(data.not_authorized){
            notify_not_authorized();
          }
          else
            sweetAlert(I18n.t('reactions.create.error'), '', 'error');
        },
        error: function () {}
      });
    });
  });
}

function delete_post() {
  $('#btn-delete-post').click(function(){
    var id = $(this).data('id');
    swal({
      title: I18n.t('warning'),
      text: I18n.t('posts.destroy.are_you_sure'),
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: swal_color,
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: false
    },
    function(){
      $.ajax({
        url: '/posts/' + id,
        type: 'DELETE',
        dataType: 'json',
        data: {},
        success: function (data) {
          if (data.type) {
            sweetAlert(I18n.t('reactions.create.success'), '', 'success');
            window.location.replace('/');
          }
          else if(data.not_login)
            window.location.replace('/users/sign_in');
          else if(data.not_authorized){
            notify_not_authorized();
          }
          else
            sweetAlert(I18n.t('reactions.create.error'), '', 'error');
        },
        error: function () {}
      });
    });
  });
}

function update_status_feedback(){
  $('.feedback').on('change','.feedback-status',function(){
    var selected = $('.feedback-status option:selected')
    var status = $("option:selected", this).html();
    var post_id = $(this).data('post-id');
    if (status === 'accept')
      text = I18n.t('confirm_accept');
    else if (status === 'reject')
      text = I18n.t('confirm_reject');
    else
      text = I18n.t('confirm_waiting');
    swal({
      title: I18n.t('info'),
      text: text,
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: swal_color,
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: true
    },
    function(){
      $.ajax({
        url: '/dashboard/feedbacks/' + post_id,
        type: 'PATCH',
        dataType: 'script',
        data: {post: {status: status}},
      });
    });
  });
}

function filter_feedback_manager(){
  $('.feedback').on('change', '.category-filter',function(){
    var category_id = $(this).val();
    var work_space_id = $('.workspace-filter').val();
    var status = $("option:selected", '.status-filter').val();
    $.ajax({
      url: '/dashboard/feedbacks',
      type: 'GET',
      dataType: 'script',
      data: {category_id: category_id, work_space_id: work_space_id, status: status}
    });
  });
  $('.feedback').on('change', '.workspace-filter',function(){
    var category_id = $('.category-filter').val();
    var work_space_id = $(this).val();
    var status = $("option:selected", '.status-filter').val();
    $.ajax({
      url: '/dashboard/feedbacks',
      type: 'GET',
      dataType: 'script',
      data: {category_id: category_id, work_space_id: work_space_id, status: status}
    });
  });
  $('.feedback').on('change', '.status-filter',function(){
    var work_space_id = $('.workspace-filter').val();
    var category_id = $('.category-filter').val();
    var status = $("option:selected", this).val();
    $.ajax({
      url: '/dashboard/feedbacks',
      type: 'GET',
      dataType: 'script',
      data: {category_id: category_id, work_space_id: work_space_id, status: status}
    });
  });
}

function validate_comment(){
  $(document).on('click','.create-comment',function(e){
    var count_length_comment = $(this).closest('.form-new-commment').find('.editable').text().length;
    if (count_length_comment == 0) {
      $('.editable').css('border','2px solid red');
      setTimeout(function(){
        $('.editable').css('border', '');
      }, 500);
    }
  });
}

$(document).ready(function(){
  delete_post();
  delete_comment();
  delete_answer();
  appcept_edit_comment();
  load_modal_edit_comment();
  correct_answer();
  add_new_comment();
  load_choose_toppic();
  load_tag_user_of_post();
  move_panel_vote();
  reaction_vote_post();
  update_status_feedback();
  filter_feedback_manager();
  validate_comment();
  show_feedback_answer();

  $('#select-toppic').change(function(){
    load_choose_toppic();
  });
});
