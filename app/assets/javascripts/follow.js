var init_follow_listener = function(){
  var followButton = $('.btn-follow');
  followButton.unbind();
  
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
    btn.closest('div').find('.btn-follow').toggleClass('hide');
    btn.attr('disabled', false);
    var user_id = btn.data('user-id');
    var id = '#followers-' + user_id;
    var label = $(id);
    var following = $('#followings-current-user');
    var current_count = label.data('count');
    var following_count = following.data('count');
    console.log(current_count);
    if(btn.hasClass('follow')){
      current_count++;
      following_count++;
    }else{
      current_count--;
      following_count--;
    }
    label.text(current_count + ' followers');
    label.data('count', current_count);
    following.text(following_count + ' followings');
    following.data('count', following_count);
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