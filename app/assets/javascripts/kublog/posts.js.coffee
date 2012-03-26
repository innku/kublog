## Starts to make js object-oriented
class KublogPost extends KublogForm
  constructor: () ->
    @title = $('#post_title')
    @body =  $('#post_body')
    @invited_author_trigger = $('#post_want_invited_author')

  validateTitle: ->
    @validatesPresenceOf @title, "title"

  validateBody: ->
    return if $(@body.val()).text().trim() isnt "" 
    @addError('body',"can't be blank")

  validateInvitedAuthor: ->
    if @invited_author_trigger.attr('checked')?
      invited_author = new KublogInvitedAuthor()
      if invited_author.validate() is false
        @addErrors(invited_author.errors)

  run_validations: ->
    @validateTitle()
    @validateBody()
    @validateInvitedAuthor()

class KublogInvitedAuthor extends KublogForm
  constructor: ->
    @name  = $('#post_invited_author_attributes_name')
    @email = $('#post_invited_author_attributes_email')

  validateName: ->
    @validatesPresenceOf @name, "invited_author_attributes_name"

  validateEmail: ->
    @validatesPresenceOf @email, "invited_author_attributes_email"
    @validatesEmailField @email, "invited_author_attributes_email"

  run_validations: ->
    @validateName()
    @validateEmail()

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

  $('#kublog #post_want_invited_author').change ->
    $wrapper = $(this).siblings('#invited_author')
    if $(this).attr('checked')?
      $wrapper.show()
    else
      $wrapper.hide()

  # We needed to remove the invited author of the has one relationship.
  # If we dont clear the attributes, Rails creates a new record 
  # with a blank name and email.
  $(".post_form").submit ->
    removeInvitedAuthorUnlessChecked()

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
    
removeInvitedAuthorUnlessChecked = ->
  $("#invited_author").remove() unless $('#post_want_invited_author').attr("checked")?
