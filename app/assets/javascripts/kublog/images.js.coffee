$(document).ready -> 

  ### Triggers when clicking image on editor ###
  $('#kublog .fancybox').fancybox
	  showCloseButton: false
	  hideOnOverlayClick: false
	
	## XHR Async Upload
  $('#kublog input.upload').livequery ->
    $(this).ajaxyUpload
     url : "#{kublogPath}images.json"
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
    url = "#{kublogPath}images/#{$('#image_id').val()}.json"
    attributes = {_method: 'put', image: { alt: $('#image_alt').val() } }
    $.post url, attributes , (data) ->
      image = { url: $('#image-upload option:selected').attr('data-url'), alt: data.alt  }
      $.wysiwyg.insertHtml $('#kublog #post_body'), imageTemplate(image)
      resetUploadForm()
      $.fancybox.close()
      
	## Resets Image Upload Form on cancel
  $('#kublog #cancel-upload').click ->
    return $.fancybox.close() if $('#image_id').val() is undefined or $('#image_id').val() is ''
    $.post "#{kublogPath}images/#{$('#image_id').val()}.json", {_method: 'delete'}
    resetUploadForm()
    $.fancybox.close()
    
### Helper Functions and Templates ###
    
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
  $('#image-upload img').attr 'src', "/assets#{kublogPath}missing_image.png"

# Templates
imageTemplate = (image) ->
  "<p><img src='#{image.url}' alt='#{image.alt}' /></p>"

linkTemplate = (image) ->
  "<small><a href='#{image.url}' target='_blank' style='display:block'>View Original</a></small>"