var editor = CKEDITOR.instances['ckeditor'];
if (editor) { editor.destroy(true);
  CKEDITOR.replace('ckeditor');
}
