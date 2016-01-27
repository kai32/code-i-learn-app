var init_follow_listener = function(){
  var followButton = $('.btn-follow');
  
  followButton.on('ajax:before', function(event, data, status){
    console.log('before');
    $(this).attr('disabled', true);
  });
  
  followButton.on('ajax:after', function(event, data, status){
    console.log('after');
    $(this).attr('disabled', false);
  });
  
  followButton.on('ajax:success', function(event, data, status){
    console.log('success');
    var btn = $(this);
    btn.closest('ul').find('.btn-follow').toggleClass('hide');
    btn.attr('disabled', false);
  });
  
  followButton.on('ajax:error', function(event, xhr, status, error){
    console.log('error');
    alert('An error occured. Request not successful');
    $(this).attr('disabled', false);
  });
};

$(document).ready(function(){
  init_follow_listener();
});