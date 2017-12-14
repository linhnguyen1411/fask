// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require ckeditor/init
//= require ckeditor/plugins/widget/plugin
//= require ckeditor/plugins/codesnippet/plugin
//= require jquery.atwho
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require_tree .
//= require bootstrap-sprockets
//= require sweetalert/dist/sweetalert.min.js
//= require social-share-button
//= require viewer.min.js
//= require jquery.mark.min.js
//= require highlight-search
//= require jquery.datetimepicker

$(document).ready(function(){
  $('a').tooltip();
  Notification.requestPermission();
  $('.zoom-img').each(function(){
    $(this).viewer();
  });
});
CKEDITOR.config.customConfig = '/assets/ckeditor/ckeditor_config.js';
