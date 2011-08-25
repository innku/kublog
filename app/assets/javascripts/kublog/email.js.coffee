$(document).ready ->
  
  ## Notification Preview
  $('#kublog .submit_fancybox').fancybox
	  showCloseButton: false
	  hideOnOverlayClick: false
	  onComplete: ->
	    textarea_html = $('#post_email_body').parent().html()
	    $('#post_email_body').data('prewysiwyg', textarea_html)
	    $('#post_email_body').wysiwyg(wysiwyg.email_controls)
	  onClosed: -> 
	    $('form.post_form').submit() if $('#post_email_body').data('ready')?
	    textarea_html = $('#post_email_body').data('prewysiwyg')
	    $('#post_email_body').parent().html(textarea_html)
      
  ## Calls Lightbox if User still decides to notify via E-mail
  $('#kublog .post_form').submit ->
    if $('#post_email_notify').attr('checked')? && not $('#post_email_body').data('ready')
      $('#post_email_body').val($(this).data('post').email_body)
      $('#link-to-email-template').click()
      return false
    else
      return true

  ## Confirms Notification text and readies for submission
  $('#kublog #email_submit').click ->
    $('#post_email_body').data('ready', true)
    $.fancybox.close()

  ## Aborts notification Submission
  $('#kublog #email_cancel').click ->
    $.fancybox.close()