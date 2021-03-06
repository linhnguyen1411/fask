$(document).ready(function(){
  jQuery(function(){
    var dateObj = new Date();
    var month = dateObj.getMonth() + 1;
    var day = dateObj.getDate();
    var year = dateObj.getFullYear();
    var currentDate = day + "/" + month + "/" + year;

    jQuery('#from-day-picker').datetimepicker({
      closeOnDateSelect: true,
      format: 'd/m/Y',
      formatDate:'d.m.Y',
      timepicker: false,
      onShow: function( ct ){
        this.setOptions({
          maxDate: jQuery('#to-day-picker').val() ? jQuery('#to-day-picker').val() : currentDate,
        })
      },
      onSelectDate:function(dp,$input){
        var topic =  $('#current-toppic').attr('data-id');
        var from_day = $input.val();
        var to_day = jQuery('#to-day-picker').val();
        var work_space_id = $('.location-dropbtn').attr('data-id');
        var sort_type = $('.sort-by-dropbtn').attr('data-id');
        var category_id = $('.category a.active').attr('data-id');
        $.ajax({
          url: '/topics/' + topic,
          method: 'GET',
          data: {
            from_day: from_day,
            to_day: to_day,
            work_space_id: work_space_id,
            sort_type: sort_type,
            category_id: category_id
          }
        });
        var params = {sort_type: sort_type, work_space_id: work_space_id, category_id: category_id, from_day: from_day, to_day: to_day};
        history.pushState(null, document.title, get_url(topic, params));
      }
    });
    jQuery('#to-day-picker').datetimepicker({
      format: 'd/m/Y',
      formatDate:'d.m.Y',
      closeOnDateSelect: true,
      defaultDate: new Date(),
      timepicker: false,
      onShow: function( ct ){
        this.setOptions({
          minDate: jQuery('#from-day-picker').val()?jQuery('#from-day-picker').val():false,
          maxDate: currentDate
        })
      },
      onSelectDate:function(dp,$input){
        var topic =  $('#current-toppic').attr('data-id');
        var to_day = $input.val();
        var from_day = jQuery('#from-day-picker').val();
        var work_space_id = $('.location-dropbtn').attr('data-id');
        var sort_type = $('.sort-by-dropbtn').attr('data-id');
        var category_id = $('.category a.active').attr('data-id');
        $.ajax({
          url: '/topics/' + topic,
          method: 'GET',
          data: {
            from_day: from_day,
            to_day: to_day,
            work_space_id: work_space_id,
            sort_type: sort_type,
            category_id: category_id
          }
        });
        var params = {sort_type: sort_type, work_space_id: work_space_id, category_id: category_id, from_day: from_day, to_day: to_day};
        history.pushState(null, document.title, get_url(topic, params));
      }
    });
  });
});

function get_url(topic, params){
  var url = '/topics/'+ topic + '/?sort_type=' + params.sort_type;
  if (!(params.work_space_id == null || params.work_space_id === '')){
    url = url + '&work_space_id='+ params.work_space_id;
  }
  if (!(params.category_id == null || params.category_id === '')){
    url = url + '&category_id=' + params.category_id;
  }
  if (!(params.from_day == null || params.from_day === '')){
    url = url + '&from_day=' + params.from_day;
  }
  if (!(params.to_day == null || params.to_day === '')){
    url = url + '&to_day=' + params.to_day;
  }
  return url;
}
$(document).ready(function(){
  filter_by_sort_type();
  filter_by_work_space();
  filter_by_category();
  var category_id = $('.current-category').attr('data-id');
  if (category_id === ''){
    $('.category a:first').addClass('active');
  }else{
    $('.category-' + category_id + ' a').addClass('active');
  }
  $(function() {
    $('.paginate-posts').on('click', 'a', function(e) {
      history.pushState(null, document.title, this.href);
    });
    $(window).bind('popstate', function() {
      $.getScript(location.href);
    });
  });
})

function filter_by_sort_type(){
  $(document).on('click','.choose-sort-type',function(){
    var topic =  $('#current-toppic').attr('data-id');
    $('#to-day-picker').val('');
    $('#from-day-picker').val('');
    var sort_type = $(this).attr('data-id');
    var work_space_id = $('.location-dropbtn').attr('data-id');
    var category_id = $('.category a.active').attr('data-id');
    $.ajax({
      url: '/topics/' + topic,
      method: 'GET',
      data: {
        work_space_id: work_space_id,
        sort_type: sort_type,
        category_id: category_id
      }
    });
    var params = {sort_type: sort_type, work_space_id: work_space_id, category_id: category_id};
    history.pushState(null, document.title, get_url(topic, params));
  })
}

function filter_by_work_space(){
  $(document).on('click','.choose-work-space',function(){
    $('#from-day-picker').val('');
    var work_space_id = $(this).attr('data-id');
    var sort_type = $('.sort-by-dropbtn').attr('data-id');
    var category_id = $('.category a.active').attr('data-id');
    $.ajax({
      url: '/topics/2',
      method: 'GET',
      data: {
        work_space_id: work_space_id,
        sort_type: sort_type,
        category_id: category_id
      }
    });
    var params = {sort_type: sort_type, work_space_id: work_space_id, category_id: category_id};
    history.pushState(null, document.title, get_url(2, params));
  })
}

function filter_by_category(){
  $(document).on('click','.category a',function(){
    $('.category a').removeClass('active')
    $(this).addClass('active');
    $('#to-day-picker').val('');
    $('#from-day-picker').val('');
    var url = '/topics/2/';
    var category_id = $(this).attr('data-id');
    if (category_id != null){
      url = url + '?category_id=' + category_id;
    }
    history.pushState(null, document.title, url);
  })
}
