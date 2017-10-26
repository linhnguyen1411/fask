function filter_by_work_space(work_space_id){
  $.ajax({
    url: '/topics/2',
    method: 'GET',
    data: {work_space_id: work_space_id}
  });
}
