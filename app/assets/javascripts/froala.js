//= require froala_editor.min.js
//= require plugins/align.min.js
//= require plugins/char_counter.min.js
//= require plugins/code_beautifier.min.js
//= require plugins/code_view.min.js
//= require plugins/colors.min.js
//= require plugins/emoticons.min.js
//= require plugins/entities.min.js
//= require plugins/file.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/fullscreen.min.js
//= require plugins/help.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/print.min.js
//= require plugins/quick_insert.min.js
//= require plugins/quote.min.js
//= require plugins/save.min.js
//= require plugins/table.min.js
//= require plugins/special_characters.min.js
//= require plugins/url.min.js
//= require plugins/video.min.js

$.extend($.FroalaEditor.POPUP_TEMPLATES, {
  'customPlugin.popup': '[_BUTTONS_][_CUSTOM_LAYER_]'
});

$.extend($.FroalaEditor.DEFAULTS, {
  popupButtons: ['popupClose', '|', 'popupButton1', 'popupButton2'],
});

$.FroalaEditor.PLUGINS.customPlugin = function (editor) {
  function initPopup () {
    var popup_buttons = '';
    if (editor.opts.popupButtons.length > 1) {
      popup_buttons += '<div class="fr-buttons text-center"><i class="fa fa-search"'
        + ' aria-hidden="true"></i><input type="text" class="tagUsers-search"></div>'
    }
    var template = {
      buttons: popup_buttons,
      custom_layer: '<div class="tagUsers-list-user">'
        + I18n.t('posts.new.form.search_user_not_found') + '</div>'
    };
    var $popup = editor.popups.create('customPlugin.popup', template);
    return $popup;
  }

  function showPopup () {
    var $popup = editor.popups.get('customPlugin.popup');
    if (!$popup) $popup = initPopup();
    editor.popups.setContainer('customPlugin.popup', editor.$tb);
    var $btn = editor.$tb.find('.fr-command[data-cmd="tagUsers"]');
    var left = $btn.offset().left + $btn.outerWidth() / 2;
    var top = $btn.offset().top + (editor.opts.toolbarBottom ? 10 : $btn.outerHeight() - 10);
    editor.popups.show('customPlugin.popup', left, top, $btn.outerHeight());
  }

  function hidePopup () {
    editor.popups.hide('customPlugin.popup');
  }

  return {
    showPopup: showPopup,
    hidePopup: hidePopup
  }
}

$.FroalaEditor.DefineIcon('tagUsersIcon', { NAME: 'address-book'})
$.FroalaEditor.RegisterCommand('tagUsers', {
  title: 'Tags User',
  icon: 'tagUsersIcon',
  undo: true,
  focus: true,
  showOnMobile: true,
  plugin: 'customPlugin',
  refreshAfterCallback: true,
  callback: function () {
    this.customPlugin.showPopup();
  }
})

function render_list_tag_users(users) {
  html = ''
  if(users.length === 0)
    html = I18n.t('posts.new.form.search_user_not_found')
  else {
    $.each(users, function( index, value ) {
      html += '<div class="tags-user-item" data-id="' + value[0] + '">' + value[1] + '</div>'
    });
  }

  $('.tagUsers-list-user').html(html);

  $('.tags-user-item').click(function() {
    $('.froalaEditor').froalaEditor('link.insert', '/users/' + $(this).data('id'),
      '<i class="fa fa-address-book-o"></i>' + $(this).html(), {'class': 'tag-user-item'});
  });
}

function ajax_tag_users(key) {
  $.ajax({
    url: '/tag_users',
    data: { key: key },
    success: function (data) {
      render_list_tag_users(data.data);
    },
    error: function () {
      response([]);
    }
  });
}

function btn_tag_users_event() {
  $('[id^="tagUsers"]').click(function(){
    $('.tagUsers-search').val('');
    ajax_tag_users('');
    $('.tagUsers-search').keyup(function(){
      ajax_tag_users($(this).val());
    });
  });
}

$(document).ready(function(){
  $('.froalaEditor').froalaEditor({
    height: 400,
    toolbarButtons: ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough',
    'subscript', 'superscript', 'fontFamily', 'fontSize', '|', 'color', 'emoticons',
    'inlineStyle', 'paragraphStyle', '|', 'paragraphFormat', 'align', 'formatOL',
    'formatUL', 'outdent', 'indent', '-', 'insertLink', 'insertImage', 'insertVideo',
    'insertFile', 'insertTable', '|', 'quote', 'insertHR', 'undo', 'redo', 'clearFormatting',
    'selectAll', 'html', 'tagUsers'],
    imageUploadURL: '/upload_image',
    imageUploadParams: {id: 'my_editor'}
  });
  btn_tag_users_event();
});
