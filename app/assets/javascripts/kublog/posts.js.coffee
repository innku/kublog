## Starts to make js object-oriented
class KublogPost
  constructor: ->
    @title = $('#post_title')
    @body = $('#post_body')
    
  validateTitle: ->
    return if @title.val() isnt ""
    @addError('title',"can't be blank")
    
  validateBody: ->
    return if $(@body.val()).text().trim() isnt "" 
    @addError('body',"can't be blank")
  
  validate: ->
    @errors = undefined
    @validateTitle()
    @validateBody()
    @errors is undefined
    
  addError: (attr, error)->
    @errors ?= {}
    @errors[attr] = [error]

window.KublogPost = KublogPost

$(document).ready ->
  # Jquery Wysiwyg editor with default configuration
  $('#kublog .editor').wysiwyg(wysiwyg.default_controls)
         
  # Counts twitter chars as a limit of 139
  # limit is given to include a shortened version of the link to post
  $('#kublog textarea[maxlength]').keyup(charCounter).keyup()
  
  # Clones title content into twitter and facebook messages
  $('#kublog .original').keyup(mimicTitle).keyup()
  
  # Server optional Hidden Fields (Currently Twitter and Facebook)
  $('#kublog .trigger-optional').change ->
    $optional = $(this).siblings('.optional')
    if $(this).attr('checked')?
      $optional.show().find('[disabled]').attr('disabled', false)
    else
      $optional.hide().find('textarea, input').attr('disabled', true)
  
  # Gets the E-mail preview of the post
  # ready for editing using a liquid template
  $('#kublog #create_post_button').click ->
    post = new KublogPost()
    window.resetErrors()
    if post.validate()
      getEmailPreview()
    else
      window.setErrors('post', post.errors)
    return false

getEmailPreview = ->
  post = { post: {title: $('#post_title').val(), body: $('#post_body').val() } }
  $.post "#{kublogPath}notifications/preview.json", post, (data) ->
    $form = $('#kublog .post_form')
    $form.data('post', data.preview)
    $form.submit()

charCounter = ->
  $chars_left_display = $(this).siblings('.chars_left')
  actual_chars_left = parseInt($(this).attr('maxlength')) - $(this).val().length
  $chars_left_display.html(actual_chars_left)
  
mimicTitle = -> $('#kublog .mimic').val($(this).val()).keyup()
    
  
