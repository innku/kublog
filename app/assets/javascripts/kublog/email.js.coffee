$(document).ready ->
  
  ## Notification Preview
  $('#kublog .submit_fancybox').fancybox
	  showCloseButton: false
	  hideOnOverlayClick: false
	  onComplete: ->
	    textarea_html = $('#post_email_body').parent().html()
	    $('.email_content').data('prewysiwyg', textarea_html)
	    $('.email_content').wysiwyg(wysiwyg.email_controls)
	  onClosed: -> 
	    $('form.post_form').submit() if $('#post_email_body').data('ready')?
	    textarea_html = $('#post_email_body').data('prewysiwyg')
	    $('#post_email_body').parent().html(textarea_html)
      
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
    $('#post_email_body').data('ready', true)
    $.fancybox.close()

  ## Aborts notification Submission
  $('#kublog #email_cancel').click ->
    $.fancybox.close()