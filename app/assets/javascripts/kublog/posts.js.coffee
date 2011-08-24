$(document).ready ->
  
  ## Editor for Post Body
  $('#kublog .editor').wysiwyg(wysiwyg.default_controls)
         
  ### Twitter Char Counter Event ###
  $('#kublog textarea[maxlength]').keyup(charCounter).keyup()
  
  ### Twitter and Facebook Post Cloning Event ###
  $('#kublog .original').keyup(mimicTitle).keyup()
  
  ### Optional Hidden Fields (Currently E-mail notifications, Twitter and Facebook) ###
  $('#kublog .trigger-optional').change ->
    $optional = $(this).siblings('.optional')
    if $(this).attr('checked')?
      $optional.show().find('[disabled]').attr('disabled', false)
    else
      $optional.hide().find('textarea, input').attr('disabled', true)
  
  ### Validates the form through AJAX on server Side ###
  $('#kublog #create_post_button').click ->
    resetErrors()
    $.post "#{kublogPath}posts/check.json?#{$(this).closest('form').first().serialize()}", (data) ->
      $form = $('#kublog .post_form')
      $form.data('post', data)
      $form.submit()
      return true
    .error (response)->
      errors =  JSON.parse(response.responseText)
      setErrors('post', errors)
    return false
    
# Handle on Event

charCounter = ->
  $chars_left_display = $(this).siblings('.chars_left')
  actual_chars_left = parseInt($(this).attr('maxlength')) - $(this).val().length
  $chars_left_display.html(actual_chars_left)
  
mimicTitle = -> $('#kublog .mimic').val($(this).val()).keyup()
    
  
