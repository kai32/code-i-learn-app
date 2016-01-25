init_listener = () ->
  console.log('init')
  $('#paginate_comments').find('.pagination a').on 'click', ->
    console.log('clicked')
    console.log($(this).attr('href'))
    $.getScript $(this).attr('href')
    return false

jQuery ->
    init_listener()
    $('#paginate_comments').on 'updated', ->
      console.log('updated')
      init_listener()
      return false
  return
  



