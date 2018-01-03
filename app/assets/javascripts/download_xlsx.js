$(document).ready(function(){
  $('.feedback').on('click','.download-xlsx', function(){
    var category_id = $('.category-filter').val();
    var work_space_id = $('.workspace-filter').val();
    var status = $('option:selected', '.status-filter').val();
    window.open('/dashboard/feedbacks.xlsx?to_xlsx=true&status='+ status+ '&category_id='+
      category_id+ '&work_space_id=' +work_space_id, '_blank');
  })
});
