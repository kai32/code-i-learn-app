var init_comment_posting = function(){
  
  $('#comment_form').on('ajax:success', function(event, data, status){
    console.log("success");
    $('#comments_container').prepend(data);
    $('#comment_form').find('textarea').val('');
    $('#comment_form').find("input[type=submit]").prop("disabled", false);
  });
  
  $('#comment_form').on('ajax:before', function(event, data, status){
    console.log("before");
   $('#comment_form').find("input[type=submit]").prop("disabled", true);
  });
  
  $('#comment_form').on('ajax:after', function(event, data, status){
    console.log("after");
    $('#comment_form').find("input[type=submit]").prop("disabled", false);
  });
  
  $('#comment_form').on('ajax:error', function(event, xhr, status, error){
    console.log('error');
    $('#comment_form').find("input[type=submit]").prop("disabled", false);
    showError("Comment must be between 10 and 300 characters");
  });
}

var showError = function(message){
  var form = $('#comment_form');
  if(form.find($('#error_expl')).length == 0){
    form.prepend($('<div id="error_expl" class="panel panel-danger">'
      + '<div class="panel-heading">Error posting comment</div>'+ 
      '<div class="panel-body"><ul><li>' + message + '</li></ul></div></div>'));
  }
  
}


$(document).ready(function(){
  init_comment_posting();
});