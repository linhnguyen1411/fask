var sweet_btn_color = '#DD6B55';

$(document).ready(function(){
  accept_feedback_post();
  reject_feedback_post();
  delete_feedback_post();
});
function accept_feedback_post(){
  $('.feedback-table').on('click', '.btn-accept-feedback', function(){
    var id = $(this).data('id');
    var status = $(this).data('status');
    swal({
      title: I18n.t('info'),
      text: I18n.t('agree'),
      type: 'info',
      showCancelButton: true,
      confirmButtonColor: sweet_btn_color,
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: true
    },
    function(){
      $.ajax({
        url: '/posts/' + id,
        type: 'PUT',
        dataType: 'script',
        data: {post: {status: status, id: id}}
      });
    });
  });
}
function reject_feedback_post(){
  $('.feedback-table').on('click', '.btn-reject-feedback', function(){
    var id = $(this).data('id');
    var status = $(this).data('status');
    swal({
      title: I18n.t('info'),
      text: I18n.t('posts.status.reject'),
      type: 'info',
      showCancelButton: true,
      confirmButtonColor: sweet_btn_color,
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: true
    },
    function(){
      $.ajax({
        url: '/posts/' + id,
        type: 'PUT',
        dataType: 'script',
        data: {post: {status: status, id: id}}
      });
    });
  });
}
function delete_feedback_post() {
  $('.feedback-table').on('click', '.btn-delete-feedback', function(){
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
        url: '/dashboard/feedbacks/' + id,
        type: 'DELETE',
        dataType: 'script'
      });
    });
  });
}
