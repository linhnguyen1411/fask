$(document).ready(function(){
  params = $('.search-params').data('query');
  if(params != " " && params != undefined){
    params = params.split(' ');
    for (i = 0; i < params.length; i ++ ){
      $('.search-highlight').mark(params[i]);
    }
  }
});
