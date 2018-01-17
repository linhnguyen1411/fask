function notify_not_authorized(response){
  swal({
    title: I18n.t('warning'),
    text: I18n.t('authorization_error'),
    type: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#DD6B55',
    confirmButtonText: I18n.t('ok'),
    cancelButtonText: I18n.t('cancel'),
    closeOnConfirm: false
  },
  function(){
    $.ajax({
      url: '/users/sign_out',
      type: 'delete',
      success: function (data) {
        window.location.replace('/users/sign_in');
      }
    });
  });
}
