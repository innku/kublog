$(document).ready ->
  
  ## Editor for Post Body
  $('#kublog .editor').wysiwyg(wysiwyg.default_controls)
  
  ### Image Insertion ###
	## Lightbox when clicking on editor
  $('#kublog .fancybox').fancybox
	  showCloseButton: false
	  hideOnOverlayClick: false
	
	## XHR Async Upload
  $('#kublog input.upload').livequery ->
    $(this).ajaxyUpload
     url : '/kublog/images.json'
     success : (data) ->
       $('#image_id').val(data.id)
       $('#image_alt').val(data.alt)
       $('#image-upload input').attr('disabled',false)
       showUploadedImage(data.file)
       enableSelect($('#image-upload select'), data)
       setImageUrls(data.file)
       console.log(data)
     start : ->
       $('#image-upload input.upload').attr('disabled',true)
       console.log('Starts Uploading')
     complete : ->
       console.log('Finished Uploading')
     error : ->
       alert('Error uploading')
       
	## Inserts configured image into post body
  $('#kublog #image-upload input[type=submit]').click ->
    url = "/kublog/images/#{$('#image_id').val()}.json"
    attributes = {_method: 'put', image: { alt: $('#image_alt').val() } }
    $.post url, attributes , (data) ->
      image = { url: $('#image-upload option:selected').attr('data-url'), alt: data.alt  }
      $.wysiwyg.insertHtml $('#kublog #post_body'), imageTemplate(image)
      resetUploadForm()
      $.fancybox.close()
	
	## Resets Image Upload Form on cancel
  $('#kublog #cancel-upload').click ->
    return $.fancybox.close() if $('#image_id').val() is undefined or $('#image_id').val() is ''
    $.post "/kublog/images/#{$('#image_id').val()}.json", {_method: 'delete'}
    resetUploadForm()
    $.fancybox.close()
    
  ### E-mail Notification ###
	##Fancybox for E-mail Notification Preview
  $('#kublog .submit_fancybox').fancybox
	  showCloseButton: false
	  hideOnOverlayClick: false
	  onComplete: ->
	    textarea_html = $('#post_email_body').parent().html()
	    $('#post_email_body').data('prewysiwyg', textarea_html)
	    $('#post_email_body').wysiwyg(wysiwyg.email_controls)
	  onClosed: -> 
	    $('#new_kublog_post').submit() if $('#post_email_body').data('ready')?
	    textarea_html = $('#post_email_body').data('prewysiwyg')
	    $('#post_email_body').parent().html(textarea_html)
      
  ## Calls Lightbox if User still decides to notify via E-mail
  $('#kublog #create_post_button').click ->
    $.post "/kublog/posts/check?#{$(this).closest('form').first().serialize()}", (data) ->
      if $('#post_email_notify').attr('checked')?
        $('#post_email_body').val(data.email_body)
        $('#link-to-email-template').click()
      else
        $('form.post_form').submit()
    return false

  ## Confirms Notification text and readies for submission
  $('#kublog #email_submit').click ->
    $('#kublog #post_email_body').data('ready', true)
    $.fancybox.close()

  ## Aborts notification Submission
  $('#kublog #email_cancel').click ->
    $.fancybox.close()


  ### Category crud ###
  $('#kublog #post_category_id').change ->
    $select = $('#post_category_id')
    if $select.val() is 'create_new_category'
      new_name = prompt('New category name')
      if new_name?
        $.post '/kublog/categories', {category: {name: new_name}}, (data)->
          $(optionTemplate(data)).insertAfter($select.find('option:first'))
          $select.val(data.id)
          if $select.find('optgroup option').length is 0
            $select.append(optGroupTemplate(data))
          else
            $select.find('optgroup').prepend(optionTemplate(data))
      else
        $select.val('')
    else if $select.find('option:selected').parent('optgroup').length isnt 0
      console.log 'Deleting category'
      $.post "/kublog/categories/#{$select.val()}.json", {_method: 'delete'}, ->
        selected_val = $select.find('option:selected').val()
        $select.find("option[value=#{selected_val}]").remove()
        $optgroup = $select.find('optgroup')
        $optgroup.remove() if $optgroup.find('option').length is 0
        $select.val('')
  
  $('#kublog #categories .delete').click ->
    $list_item = $(this).closest('li')
    if confirm($(this).attr('data-confirm'))
      $.post $list_item.children('a').attr('href'), {_method: 'delete'}, ->
        $list_item.remove()
    return false
      
  $('#kublog #categories .edit').click ->
    $link = $(this).closest('li').children('a')
    new_name = prompt($(this).attr('data-prompt'), $link.text())
    if new_name?
      $.post $link.attr('href'), {_method: 'put', category: {name: new_name}}, (data)->
        $link.text(data.name)
        $link.attr('href', data.path)
    return false
    
    
        
  ### Twitter ###
  $('#kublog textarea[maxlength]').keyup(char_counter).keyup()
  
  ### Twitter and Facebook ###
  $('#kublog #post_title').keyup(mimic_title).keyup()
  
  ### Twitter, Facebook and E-mail ###
  $('#kublog .trigger-optional').change ->
    $optional = $(this).siblings('.optional')
    if $(this).attr('checked')?
      $optional.show()
      $optional.find('input,textarea').attr('disabled', false)
    else
      $optional.hide()
      $optional.find('input,textarea').attr('disabled', true)
  
# Handle on Event

showUploadedImage = (image)->
  $('#image-upload img').attr('src', image.small.url)
  $('#image-upload .container').append(linkTemplate(image))
  
setImageUrls = (image)->
  $('#image-upload option[value=original]').attr('data-url', image.url)
  $('#image-upload option[value=small]').attr('data-url', image.small.url)
  $('#image-upload option[value=thumb]').attr('data-url', image.thumb.url)

enableSelect = ($select, data)->
  $select.find('option:first').remove()
  text = 'Insert Original'
  dimensions = "(#{data.file_width}x#{data.file_height})"
  $select.find('option:first').text("#{text} #{dimensions}")
  $select.attr('disabled',false)
  
resetUploadForm = ->
  $('#image-upload option').attr 'data-url', ''
  $('#image-upload option:first').text 'Insert Original'
  $('#image-upload select').prepend('<option></option>').attr('disabled',true).val('')
  $('#image-upload small').remove()
  $('#image-upload input[type=text]').val('').attr('disabled', true)
  $('#image-upload input[type=file]').attr 'disabled', false 
  $('#image-upload img').attr 'src', '/assets/kublog/missing_image.png'

# Templates
imageTemplate = (image) ->
  "<p><img src='#{image.url}' alt='#{image.alt}' /></p>"

linkTemplate = (image) ->
  "<small><a href='#{image.url}' target='_blank' style='display:block'>View Original</a></small>"
  
optionTemplate = (category) ->
  "<option value=#{category.id}>#{category.name}</option>"
  
optGroupTemplate = (category) ->
  "<optgroup label='Remove Category'>#{optionTemplate(category)}</optgroup>"
  
char_counter = ->
  $chars_left_display = $(this).siblings('.chars_left')
  actual_chars_left = parseInt($(this).attr('maxlength')) - $(this).val().length
  $chars_left_display.html(actual_chars_left)
  
mimic_title = ->
  $('#kublog #post_tweet_text').val($(this).val()).keyup()
  $('#kublog #post_facebook_text').val($(this).val())