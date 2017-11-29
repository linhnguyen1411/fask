$(document).ready(function(){
  $('.a-version-avatar img').css('max-width', '70%');
  $('.improve-post').click(function(){
    $('#improve-form').slideToggle();
    $('.fr-placeholder').html("");
    $('#ckeditor-improve-form').html($('.post-content').html());
    var ck = $('.ckeditor');
    $.each(ck, function(i) {
      if (ck[i].id == 'ckeditor-improve-form'){
        var editor = CKEDITOR.instances['ckeditor-improve-form'];
        if (editor) { editor.destroy(true); }
        CKEDITOR.replace(ck[i]);
      }
    });

    $('.improve-btn').click(function(e){
      e.preventDefault();
      if($('.post-content').html() == $('.improve-content .fr-element.fr-view').html())
        sweetAlert(I18n.t('version.no_change'), '', 'error');
      else{
        swal({
          title: I18n.t("info"),
           text: I18n.t("version.waiting_response"),
            type: "success"
          },
          function(){
            $('.improve-content').parents('form').submit();
        });
      }
    });
  });
  $('.edit-improvement').click(function(){
    var id = $(this).attr('id');
    $('#edit-form-'+id).slideToggle();
  });
  read_more();
  reject_a_version();
  approve_a_version();
});

function read_more(){
  var showChar = 300;
  var ellipsestext = '...';
  var moretext = I18n.t('version.show_more');
  var lesstext = I18n.t('version.show_less');
  $('.more').each(function() {
    var content = $(this).text();
    if(content.length > showChar) {
      $(this).closest('.hide-improve').find('.show-more-link').html('</span>&nbsp;&nbsp;<a href="" class="morelink less">' + moretext + '</a></span>');
      $(this).addClass('show-more');
    }
  });
  $('.morelink').click(function(){
    if($(this).hasClass('less')) {
      $(this).removeClass('less');
      $(this).html(lesstext);
      $(this).closest('.hide-improve').find('.more').removeClass('show-more');
    }
    else {
      $(this).closest('.hide-improve').find('.more').addClass('show-more');
      $(this).html(moretext);
      $(this).addClass('less');
    }
    return false;
  });
}

function approve_a_version() {
  $('#a-version-body').on('click', '.btn-approve-a-version', function(){
    var id = $(this).data('id');
    var status = $(this).data('status');
    var post_id = $(this).data('post-id');
    var type = $(this).data('type');
    var content = $(this).data('content');
    swal({
      title: I18n.t('info'),
      text: I18n.t('agree'),
      type: 'info',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: true
    },
    function(){
      $.ajax({
        url: '/a_versions/' + id,
        type: 'PUT',
        dataType: 'script',
        data: {status: status, post_id: post_id, type: type}
      });
    });
  });
}
function reject_a_version() {
  $('#a-version-body').on('click', '.btn-reject-a-version', function(){
    var id = $(this).data('id');
    var status = $(this).data('status');
    var current_status = $(this).data('current-status');
    var post_id = $(this).data('post-id');
    if(current_status === 'accept')
      text = I18n.t('version.reject_approved');
    else
      text = I18n.t('cancel_version');
    swal({
      title: I18n.t('warning'),
      text: text,
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#DD6B55',
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: false
    },
    function(){
      $.ajax({
        url: '/a_versions/' + id,
        type: 'PUT',
        dataType: 'json',
        data: { status: status, post_id: post_id },
        success: function (data) {
          if (data.type) {
            if (current_status === 'accept'){
              sweetAlert(I18n.t('reactions.create.success'), '', 'success');
              $('.a-version-'+ id ).fadeOut();
              $('.post-content').html(data.default_content);
            }
            else{
              sweetAlert(I18n.t('reactions.create.success'), '', 'success');
              $('.a-version-'+ id ).fadeOut();
            }
          }
          else if(data.not_login)
            window.location.replace('/users/sign_in');
          else
            sweetAlert(I18n.t('reactions.create.error'), '', 'error');
        },
        error: function () {}
      });
    });
  });
}
