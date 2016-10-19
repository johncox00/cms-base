$(document).ready(function(){
  $('.role-check').change(function(){
    id = $(this).attr('id').split('--')[1];
    r = $(this).val();
    a = 'remove';
    if($(this).prop('checked')){
      a = 'add';
    }
    $.ajax({
      url: '/users/'+id+'/update_roles',
      type: 'PUT',
      contentType: "application/json",
      data: JSON.stringify({ user: { roles: [ {role: r, action: a } ] } }),
      success: function(result) {
          console.log('successfully updated');
      }
    });
  });
});
