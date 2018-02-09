$(document).ready(function(){
  show_fast_answer();
});
function show_fast_answer() {
  $(document).on('click', '.count-answer', function(){
    var post_id = $(this).data('id');
    var count_answer = $(this).text();
    if(count_answer != 0){
      $.ajax({
        url: '/answers?post_id=' + post_id,
        type: 'GET',
        dataType: 'script'
      });
    }else{
      swal({
        position: 'top-end',
        type: 'warning',
        title: I18n.t('no_answer'),
        showConfirmButton: false,
        timer: 700
      })
    }
  });
}
