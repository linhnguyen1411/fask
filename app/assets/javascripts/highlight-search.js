$(document).ready(function(){
  params = $('.search-params').data('query');
  if params != " "
  for (i = 0; i < params.length; i ++ ){
    $('.search-highlight').mark(params[i]);
  }
});
