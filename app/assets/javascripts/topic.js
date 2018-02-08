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
    var to_day = $('#to-day-picker').val();
    var from_day = $('#from-day-picker').val();
    var sort_type = $(this).attr('data-id');
    var work_space_id = $('.location-dropbtn').attr('data-id');
    var category_id = $('.category a.active').attr('data-id');
    $.ajax({
      url: '/topics/' + topic,
      method: 'GET',
      data: {
        work_space_id: work_space_id,
        from_day: from_day,
        to_day: to_day,
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
    var to_day = $('#to-day-picker').val();
    var from_day = $('#from-day-picker').val();
    $('#from-day-picker').val('');
    $('#to-day-picker').val('');
    var work_space_id = $(this).attr('data-id');
    var sort_type = $('.sort-by-dropbtn').attr('data-id');
    var category_id = $('.category a.active').attr('data-id');
    $.ajax({
      url: '/topics/2',
      method: 'GET',
      data: {
        work_space_id: work_space_id,
        sort_type: sort_type,
        from_day: from_day,
        to_day: to_day,
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
      url = url + '?category_id=' + category_id ;
    }
    history.pushState(null, document.title, url);
  })
}

$(document).ready(function(){
  $(document).on('click','.previous-week', function(){
    var topic =  $('#current-toppic').attr('data-id');
    var to_day = $('#to-day-picker').val();
    var from_day = $('#from-day-picker').val();
    var sort_type = $('.sort-by-dropbtn').attr('data-id');
    var work_space_id = $('.location-dropbtn').attr('data-id');
    var category_id = $('.category a.active').attr('data-id');
    var previous_week = true;
    $.ajax({
      url: '/topics/2',
      method: 'GET',
      dataType: 'script',
      data: {
        previous_week: previous_week,
        from_day: from_day,
        to_day: to_day,
        work_space_id: work_space_id,
        sort_type: sort_type,
        category_id: category_id
      }
    });
  });
  $(document).on('click','.next-week', function(){
    var topic =  $('#current-toppic').attr('data-id');
    var to_day = $('#to-day-picker').val();
    var from_day = $('#from-day-picker').val();
    var sort_type = $('.sort-by-dropbtn').attr('data-id');
    var work_space_id = $('.location-dropbtn').attr('data-id');
    var category_id = $('.category a.active').attr('data-id');
    var next_week = true;
    $.ajax({
      url: '/topics/2',
      method: 'GET',
      dataType: 'script',
      data: {
        next_week: next_week,
        from_day: from_day,
        to_day: to_day,
        work_space_id: work_space_id,
        sort_type: sort_type,
        category_id: category_id
      }
    });
  })
});

$(document).ready(function(){
  var onoffswitch_qa = $('#on_off_topic_1');
  var onoffswitch_feedback = $('#on_off_topic_2');
  var onoffswitch_confession = $('#on_off_topic_3');
  var stauts = false;
  onoffswitch_qa.on('change', function(){
    if ($(this).is(':checked')) {
      status = true;
    }
    else {
      status = false;
    }
    $.ajax({
      url: '/topics/1',
      type: 'PATCH',
      dataType: 'script',
      data: {status: status}
    });
  });
  onoffswitch_feedback.on('change', function(){
    if ($(this).is(':checked')) {
      status = true;
    }
    else {
      status = false;
    }
    $.ajax({
      url: '/topics/2',
      type: 'PATCH',
      dataType: 'script',
      data: {status: status}
    });
  });
  onoffswitch_confession.on('change', function(){
    if ($(this).is(':checked')) {
      status = true;
    }
    else {
      status = false;
    }
    $.ajax({
      url: '/topics/3',
      type: 'PATCH',
      dataType: 'script',
      data: {status: status}
    });
  });
});
