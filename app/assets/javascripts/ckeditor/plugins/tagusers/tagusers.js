CKEDITOR.plugins.add('tagusers', {
  requires: 'richcombo',
  init: function(editor) {
    var config = editor.config,
    userList = [];
    $.ajax({
    url: '/tag_users',
    data: { key: '' },
    success: function (data) {
      for (var i = data.data.length - 1; i >= 0; i--) {
        userList.push(data.data[i]);
      }
    },
      error: function () {
        response([]);
      }
    });
    editor.ui.addRichCombo('TagUsers', {
      label: 'Tag Users',
      title: 'Tag Users',
      panel: {
        css: [ CKEDITOR.skin.getPath( 'editor' ) ].concat( config.contentsCss ),
                    multiSelect: false,

        attributes: { 'aria-label': 'Tag Users' }
      },
      init: function() {
        this.add('search', '<div onmouseover="parent.comboSearch(this);"' +
          'onclick="parent.nemsComboSearch(this);"><span class="fa fa-search"></span><input class="tagUsers-search cke_search"' +
          '"/></div>', '');
        for (var i = 0 ; i < userList.length ; i++) {
          this.add('<a class="tag-user-item" href="/users/' + userList[i][0] +
            '"><span class="fa fa-address-book-o"></span>' + userList[i][1] + '</a> ',
            '<span class="fa fa-address-book-o">&nbsp;' + userList[i][1]+ '</span>', userList[i][1]);
        }
        this.commit();
      },
      onClick: function(value) {
        editor.insertHtml(value);
        editor.fire('saveSnapshot');
      }
    });
  }
} );
if(!jQuery.expr[':'].icontains){
  jQuery.expr[':'].icontains = function(a, i, m) {
    return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
  };
 }
window.comboSearch= function(element) {
  var anchorID = $(element).closest('a').attr("id");
  var liDom = $(element).closest('li');
  liDom.empty().append('<div id="' + anchorID + '" style="padding: 6px 7px !important; border-bottom: 1px solid #000;">' +
    '<span class="fa fa-search"></span><input class="tagUsers-search cke_search"/></div>');
  liDom.find('input').off("keyup").on("keyup", function() {
    var data = this.value;
    var jo = liDom.siblings('li');
    filter.call(this, data, jo);
  }).focus(function() {
    this.value = "";
    $(this).unbind('focus');
  });
};
function filter(data, jo) {
  if (this.value === "") {
    jo.show();
    return;
  }
  jo.hide();
  jo.filter(function(i, v) {
    var $t = $(this);
    if ($t.is(":icontains('" + data + "')")) {
      return true;
    }
    return false;
  }).show();
}
