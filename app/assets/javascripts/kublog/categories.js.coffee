$(document).ready ->
  # Create category on the Fly
  $('#kublog #post_category_id').change ->
    $select = $('#post_category_id')
    if $select.val() is 'create_new_category'
      new_name = prompt('New category name')
      if new_name?
        $.post "#{kublogPath}categories", {category: {name: new_name}}, (data)->
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
      $.post "#{kublogPath}categories/#{$select.val()}.json", {_method: 'delete'}, ->
        selected_val = $select.find('option:selected').val()
        $select.find("option[value=#{selected_val}]").remove()
        $optgroup = $select.find('optgroup')
        $optgroup.remove() if $optgroup.find('option').length is 0
        $select.val('')
  
  # Delete Category
  $('#kublog #categories .delete').click ->
    $list_item = $(this).closest('li')
    if confirm($(this).attr('data-confirm'))
      $.post $list_item.children('a').attr('href'), {_method: 'delete'}, ->
        $list_item.remove()
    return false
      
  # Edit Category
  $('#kublog #categories .edit').click ->
    $link = $(this).closest('li').children('a')
    new_name = prompt($(this).attr('data-prompt'), $link.text())
    if new_name?
      $.post $link.attr('href'), {_method: 'put', category: {name: new_name}}, (data)->
        $link.text(data.name)
        $link.attr('href', data.path)
    return false
    
optionTemplate = (category) ->
  "<option value=#{category.id}>#{category.name}</option>"

optGroupTemplate = (category) ->
  "<optgroup label='Remove Category'>#{optionTemplate(category)}</optgroup>"
