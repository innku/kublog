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
  # check doesn't care if editing or creating new post
  $('#kublog #create_post_button').click ->
    resetErrors()
    post = { post: {title: $('#post_title').val(), body: $('#post_body').val() } }
    $.post "#{kublogPath}notifications/preview.json", post, (data) ->
      $form = $('#kublog .post_form')
      $form.data('post', data.preview)
      $form.submit()
    return false
    
# Handle on Event

charCounter = ->
  $chars_left_display = $(this).siblings('.chars_left')
  actual_chars_left = parseInt($(this).attr('maxlength')) - $(this).val().length
  $chars_left_display.html(actual_chars_left)
  
mimicTitle = -> $('#kublog .mimic').val($(this).val()).keyup()
    
  
