window.wysiwyg = { }
window.wysiwyg.default_controls =
	controls:
		bold : { visible : true }
		italic : { visible : true }
		insertOrderedList    : { visible : true }
		insertUnorderedList  : { visible : true }
		html  : { visible: true }
		createLink: 
      tooltip: "Create Link"
		insertImage:
			exec: -> $('#link-to-upload').click()
			tooltip: "Insert image"
		underline     : { visible : false }
		strikeThrough : { visible : false }
		justifyLeft   : { visible : false }
		justifyCenter : { visible : false }
		justifyRight  : { visible : false }
		justifyFull   : { visible : false }
		indent  : { visible : false }
		outdent : { visible : false }
		subscript   : { visible : false }
		superscript : { visible : false }
		undo : { visible : false }
		redo : { visible : false }
		insertHorizontalRule : { visible : false }
		h1: {visible: false}
		h4: {visible: false}
		h5: {visible: false}
		h6: {visible: false}
		cut   : { visible : false }
		copy  : { visible : false }
		paste : { visible : false }
		increaseFontSize : { visible : false }
		decreaseFontSize : { visible : false }
		
window.wysiwyg.email_controls =
	controls:
		bold          : { visible : true }
		italic        : { visible : true }
		insertOrderedList    : { visible : true }
		insertUnorderedList  : { visible : true }
		html  : { visible: true }
		createLink: { tooltip: "Create Link" }
		insertImage   : { visible : false}
		underline     : { visible : false }
		strikeThrough : { visible : false }
		justifyLeft   : { visible : false }
		justifyCenter : { visible : false }
		justifyRight  : { visible : false }
		justifyFull   : { visible : false }
		indent  : { visible : false }
		outdent : { visible : false }
		subscript   : { visible : false }
		superscript : { visible : false }
		undo : { visible : false }
		redo : { visible : false }
		insertHorizontalRule : { visible : false }
		h1: {visible: false}
		h4: {visible: false}
		h5: {visible: false}
		h6: {visible: false}
		cut   : { visible : false }
		copy  : { visible : false }
		paste : { visible : false }
		increaseFontSize : { visible : false }
		decreaseFontSize : { visible : false }