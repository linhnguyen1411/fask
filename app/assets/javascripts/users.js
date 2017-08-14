function load_user_avatar(input, klass) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('.' + klass).attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
};

$(document).ready(function(){
  $('.upload-user-avatar').on('change', function() {
    load_user_avatar(this, 'img-upload');
  });
});
