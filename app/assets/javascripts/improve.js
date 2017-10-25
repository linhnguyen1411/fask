$(document).ready(function(){
  $('.a-version-avatar img').css('max-width', '70%');
  $('.improve-post').click(function(){
    $('#improve-form').slideToggle();
    $('.fr-placeholder').html("");
    $('.improve-content .fr-element.fr-view').html($('.post-content').html());
    $('.improve-btn').click(function(e){
      e.preventDefault();
      if($('.post-content').html() == $('.improve-content .fr-element.fr-view').html())
        {
         sweetAlert(I18n.t('version.no_change'), '', 'error');
        }
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
$(document).ready(function() {
  var showChar = 300;
  var ellipsestext = "...";
  var moretext = "Show more >>";
  var lesstext = "Show less";
  $('.more').each(function() {
    var content = $(this).text();
    if(content.length > showChar) {
      var c = content.substr(0, showChar);
      var h = content.substr(showChar, content.length - showChar);
      var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
      $(this).html(html);
    }
  });
  $('.morelink').click(function(){
    if($(this).hasClass('less')) {
      $(this).removeClass('less');
      $(this).html(moretext);
    } else {
      $(this).addClass('less');
      $(this).html(lesstext);
    }
    $(this).parent().prev().toggle();
    $(this).prev().toggle();
    return false;
  });
});
function approve_a_version() {
  $('.btn-approve-a-version').click(function(){
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
      closeOnConfirm: false
    },
    function(){
      $.ajax({
        url: '/a_versions/' + id,
        type: 'PUT',
        dataType: 'json',
        data: {status: status, post_id: post_id,type: type},
        success: function (data) {
          if (data.type) {
            sweetAlert(I18n.t('reactions.create.success'), '', 'success');
            $('.a-version-status-'+id).html(I18n.t('version.status')+': '+
              '<span class="version-status-accept">'+ status +'</span>');
            $('.version-accept').html(I18n.t('version.status')+': '+
              '<span class="version-status-improve">'+ I18n.t('version.improve')+ '</span>');
            $('.post-content').html(content);
            $('#accept-'+id).fadeOut();
            $('.pick-'+id).append('<span class="tick"><i class="fa fa-check" aria-hidden="true"></i></span>');
            $('.tick-accept').fadeOut();
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
function reject_a_version() {
  $('.btn-reject-a-version').click(function(){
    var id = $(this).data('id');
    var status = $(this).data('status');
    var cstatus = $(this).data('cstatus');
    if(cstatus == "accept"){
      text = I18n.t('version.reject_approved');
    }
    else {
      text = I18n.t('cancel_version');
    }
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
        data: { status: status },
        success: function (data) {
          if (data.type) {
            if (cstatus == "accept"){
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
