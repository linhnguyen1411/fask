$(document).ready(function(){
  $('.choose-language').click(function(){
    var id = $(this).attr('id');
    window.location.pathname = 'update'
    window.location = '/change_languages/update?locale=' + id;
  });
});
