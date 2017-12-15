function filter_by_work_space(work_space_id){
  $.ajax({
    url: '/topics/2',
    method: 'GET',
    data: {work_space_id: work_space_id}
  });
}

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
          maxDate: currentDate,
        })
      },
      onSelectDate:function(dp,$input){
        var topic =  $('#current-toppic').attr('data-id');
        var from_day = $input.val();
        var to_day = jQuery('#to-day-picker').val();
        var work_space_id = $('.location-dropbtn').attr('data-id');
        $.ajax({
          url: '/topics/' + topic,
          method: 'GET',
          data: {
            from_day: from_day,
            to_day: to_day,
            work_space_id: work_space_id
          }
        });
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
          minDate: jQuery('#from-day-picker').val()?jQuery('#from-day-picker').val():false
        })
      },
      onSelectDate:function(dp,$input){
        var topic =  $('#current-toppic').attr('data-id');
        var to_day = $input.val();
        var from_day = jQuery('#from-day-picker').val();
        var work_space_id = $('.location-dropbtn').attr('data-id');
        $.ajax({
          url: '/topics/' + topic,
          method: 'GET',
          data: {
            from_day: from_day,
            to_day: to_day,
            work_space_id: work_space_id
          }
        });
      }
    });
  });
});
