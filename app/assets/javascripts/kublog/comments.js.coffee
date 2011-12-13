$(document).ready ->
  
  $('#kublog #new_comment').submit ->
    $(this).find('input[type=submit]').removeClass('btn').addClass('btn-disabled').attr('disabled', 'disabled')
    $(this).find('.spinner_div').show();
    resetErrors()
  
  $('#kublog #new_comment').bind 'ajax:success', (xhr, data, status)->
    $('.post-comments').append(commentTemplate(data.comment))
    $(this).find('textarea,input[type=text]').val('')
    $(this).find('input[type=submit]').removeClass('btn-disabled').addClass('btn').removeAttr('disabled')
    $(this).find('.spinner_div').hide();
    # Increment the number of comments
    $count = $('.post-comments .comments-count')
    comments_count = parseInt($count.text(), 10)
    $count.html($count.text().replace(comments_count, comments_count+1))


  $('#kublog #new_comment').bind 'ajax:error', (xhr, error, status)->
    errors =  JSON.parse(error.responseText)
    setErrors('comment', errors)
    $(this).find('input[type=submit]').removeClass('btn-disabled').addClass('btn').removeAttr('disabled')
    $(this).find('.spinner_div').hide();
    
  $('#kublog .comment a.delete').click ->
    $link = $(this)
    if confirm($(this).attr('data-confirm'))
      $.post $link.attr('href'), { _method: 'delete'}, (data) ->
        $link.closest('.comment').remove()
    false
    
# Templates
commentTemplate = (comment) ->
  extra_class = 'admin' if comment['admin?']
  """
  <div class='comment #{extra_class}'>
    <h4>#{comment.author}</h4> 
    <span class='time'>#{comment.ftime}</span> 
    <p class='body'>#{comment.body}</p> 
  </div>
  """
