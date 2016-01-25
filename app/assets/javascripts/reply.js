var init_reply_listener = function(){
  $('#reply-form-container a').unbind();
  $('#reply-form-container a').on('click', function(){
    var link = $(this);
    if(link.hasClass('reply')){
      link.text('Hide');
      link.addClass('hide-reply');
      link.removeClass('reply');
      var replyForm = $('#comment_form').clone();
      replyForm.attr("id","reply_form");
      //add hidden field here
      replyForm.append($('<input value="' + link.data('parent-id') + '" type="hidden" name="comment[parent_id]" id="comment_parent_id" />'))
      link.closest('.well').append(replyForm);
      init_reply_submit_listener();
    }else{
      link.text('Reply');
      link.addClass('reply');
      link.removeClass('hide-reply');
      link.closest('.well').find('#reply_form').remove();
    }
    return false;
  });
  
};

var init_reply_submit_listener = function(){
  console.log('init');
  $('#reply_form').unbind();
  
  $('#reply_form').on('ajax:success', function(event, data, status){
    console.log("success");
    var form = $(this);
    form.parent().find('.comment-replies').append(data);
    init_reply_listener();
    form.remove();
  });
  
  $('#reply_form').on('ajax:before', function(event, data, status){
    console.log("before");
   $('this').find("input[type=submit]").prop("disabled", true);
  });
  
  $('#reply_form').on('ajax:after', function(event, data, status){
    console.log("after");
    $(this).find("input[type=submit]").prop("disabled", false);
  });
  
  $('#reply_form').on('ajax:error', function(event, xhr, status, error){
    console.log('error');
    $(this).find("input[type=submit]").prop("disabled", false);
    showError("Comment must be between 10 and 300 characters");
  });
}

$(document).ready(function(){
  init_reply_listener();
});