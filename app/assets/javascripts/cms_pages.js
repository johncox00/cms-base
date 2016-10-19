$(document).ready(function(){
  $('#myModal').on('hide.bs.modal', function (e) {
    var allVals = [];
    $('#content_item_checks :checked').each(function() {
      allVals.push($(this).val());
    });
    console.log(allVals);
    $.ajax({
      url: '/cms_pages/'+id+'/content_items',
      type: 'PUT',
      data: {cms_page: {content_items: allVals}},
      success: function(result) {
          console.log('successfully updated');
      }
    });
  });
});
