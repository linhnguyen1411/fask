$(document).ready(function(){
  $('.a-version-avatar img').css('max-width', '70%');
  $('.improve-post').click(function(){
    $('#improve-form').slideToggle();
    $('.fr-placeholder').html("");
    $('.improve-content .fr-element.fr-view').html($('.post-content').html());
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
  reject_a_version();
  approve_a_version();
});
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
  $('.btn-reject-a-version').click(function(){
    var id = $(this).data('id');
    var status = $(this).data('status');
    var current_status = $(this).data('current-status');
    alert(current_status);
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
            if (cstatus === 'accept'){
              sweetAlert(I18n.t('reactions.create.success'), '', 'success');
              $('.a-version-'+ id ).fadeOut();
              $('.post-content').html($('#content-post-hidden').val());
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
