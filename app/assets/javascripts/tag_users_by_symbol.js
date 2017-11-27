$(document).ready(function(){
  $('.editable').each(function(){
    CKEDITOR.disableAutoInline = true;
  });
  var userList = [];
  $.ajax({
    url: '/tag_users',
    data: { key: '' },
    async: false,
    success: function (data) {
      for (var i = data.data.length - 1; i >= 0; i--) {
        userList.push({'id' :data.data[i][0], 'name' :data.data[i][1] });
      }
    },
    timeout: 3000
  });
  $('.editable').atwho({
    at: '@',
    data: userList,
    startWithSpace: true,
    searchKey: 'name',
    insertTpl: ('<a class="tag-user-item" href="/users/${id}"><span class="fa fa-address-book-o"></span>&nbsp;${name}</a>'),
    displayTpl: ('<li><a class="tag-user-item" href="/users/${id}"><span class="fa fa-address-book-o"></span>&nbsp;${name}</a></li>')
  });
  $(document).on('click', '.comment-form', (function() {
    $(this).find('.txta-tag-users').val($(this).closest('.form-new-commment').find('.editable').html());
  }));
});
