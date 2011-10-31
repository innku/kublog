$(document).ready ->
  
  $('#kublog #new_kublog_comment').submit ->
    resetErrors()
  
  $('#kublog #new_kublog_comment').bind 'ajax:success', (xhr, data, status)->
    $('.post-comments').append(commentTemplate(data.comment))
    $(this).find('textarea,input[type=text]').val('')
    
  $('#kublog #new_kublog_comment').bind 'ajax:error', (xhr, error, status)->
    errors =  JSON.parse(error.responseText)
    setErrors('comment', errors)
    
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
