var init_favourite_listener = function(){
  var favouriteButton = $('.btn-favourite');
  favouriteButton.unbind();
  
  favouriteButton.on('ajax:before', function(event, data, status){
    console.log('before');
    $(this).attr('disabled', true);
  });
  
  favouriteButton.on('ajax:after', function(event, data, status){
    console.log('after');
    $(this).attr('disabled', false);
  });
  
  favouriteButton.on('ajax:success', function(event, data, status){
    console.log('success');
    var btn = $(this);
    $('.btn-favourite').toggleClass('hide');
    btn.attr('disabled', false);
  });
  
  favouriteButton.on('ajax:error', function(event, xhr, status, error){
    console.log('error');
    alert('An error occured. Request not successful');
    $(this).attr('disabled', false);
  });
};

$(document).ready(function(){
  init_favourite_listener();
});