$(document).ready ->
  
  ### Special Optional fields are not shown on check, but only enabled ###
  $('#kublog .email_checkbox').change ->
    $optional = $(this).siblings('.optional')
    $optional_lightbox = $(this).siblings('.optional_lightbox')
    if $(this).attr('checked')?
      $optional.show().find('[disabled]').attr('disabled', false)
      $optional_lightbox.find('[disabled]').attr('disabled', false)
    else
      $optional.hide().find('textarea, input').attr('disabled', true)
      $optional_lightbox.find('textarea, input').attr('disabled', true)
  
  ## Notification Preview
  $('#kublog .submit_fancybox').fancybox
	  showCloseButton: false
	  hideOnOverlayClick: false
	  onComplete: ->
	    textarea_html = $('.email_content').parent().html()
	    $('.email_content').data('prewysiwyg', textarea_html)
	    $('.email_content').wysiwyg(wysiwyg.email_controls)
	  onClosed: -> 
	    $('form.post_form').submit() if $('.email_content').data('ready')?
	    textarea_html = $('.email_content').data('prewysiwyg')
	    $('.email_content').parent().html(textarea_html)
      
  ## Calls Lightbox if User still decides to notify via E-mail
  $('#kublog .post_form').submit ->
    $email_checkbox = $('.email_checkbox')
    $email_content = $('.email_content')
    if $email_checkbox.attr('checked')? && not $email_content.data('ready')
      $email_content.val($(this).data('post'))
      $('#link-to-email-template').click()
      return false
    else
      return true

  ## Confirms Notification text and readies for submission
  $('#kublog #email_submit').click ->
    $('.email_content').data('ready', true)
    $.fancybox.close()

  ## Aborts notification Submission
  $('#kublog #email_cancel').click ->
    $.fancybox.close()