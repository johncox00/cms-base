function pageLoad(){
  $('.ckeditor').ckeditor({
    // optional config
  });
}

$(document).ready(pageLoad());
$(document).on('page:load', pageLoad);
