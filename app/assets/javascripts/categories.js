$(document).ready(function(){
  category_management();
  delete_category();
});
function category_management(){
  $('.management').on('click', '#category', function(){
    $.ajax({
      url: '/categories/',
      type: 'GET',
      dataType: 'script'
    });
  });
}
function delete_category() {
  $('.management-content').on('click', '.btn-delete-category', function(){
    var id = $(this).data('id');
    var page = $(this).data('page');
    swal({
      title: I18n.t('warning'),
      text: I18n.t('category_management.destroy.are_you_sure'),
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: swal_color,
      confirmButtonText: I18n.t('ok'),
      cancelButtonText: I18n.t('cancel'),
      closeOnConfirm: false
    },
    function(){
      $.ajax({
        url: '/categories/' + id,
        type: 'DELETE',
        dataType: 'script',
        data:{ page: page}
      });
    });
  });
}
