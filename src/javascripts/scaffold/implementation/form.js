;(function($) {
		   
	$('#body .form .cancel').live('click', function(event) {
	
		var   $this = $(this);
		
		// show the loader
		$this.addClass('loading');
		$.ajax({url: $this.attr('href')});
		return false;
	});
		   
	// pull out our subform commented out buttons since we have javascript (these should not show without js, hence the comments)
	$('#body .form .sub-form td.delete,#body .form .sub-form tr.new-row-button td').livequery(function() {
	
		var   $this = $(this)
			, $comment = $this.comments();
		$this.append($comment.html());
	});
	
	// setup our add buttons to create another row
	$('#body .form .sub-form button.sub-form-add-button').live('click', function() {
	
		var   $this = $(this)
			, $newRow = $this.parents('.sub-form').find('tr.new-row').comments()
			, $tr = $this.parents('tr')
			, time = new Date().getTime();
		
		$newRow.find('input,select,textarea').each(function(i) {
			$(this).attr('name', $(this).attr('name').replace(/\d+/, time));	
			$(this).attr('id', $(this).attr('id').replace(/\d+/, time));
		});
		
		$newRow.find('label').each(function(i) {
			$(this).attr('for', $(this).attr('for').replace(/\d+/, time));	
		});
		
		$tr.before($newRow.find('tr'));
		return false;
	});
	
	// setup our delete buttons 
	$('#body .form .sub-form a.sub-form-delete-button').live('click', function() {
	
		var   $this = $(this)
			, $deleteInput = $this.parents('tr').find('input[name*=_delete]')
			, $tr = $this.parents('tr');
		
		$deleteInput.val('1');
		$tr.hide();
		return false;
	});
	
	// any subform field we type in should set the delete to false for the row
	$('#body .form .sub-form input,#body .form .sub-form select').live('focus', function() {
	
		var   $this = $(this)
			, $deleteInput = $this.parents('tr').find('input[name*=_delete]');
		
		$deleteInput.val('0');
	});

	// setup our forms to submit via ajax and to handle errors and redirection
	$('#body .form form[enctype!=multipart/form-data]').live('submit', function(event) {
	
		var   $this = $(this)
			, $button = $this.find('.interface-button');
		
		$button.removeClass('save')
			.removeClass('delete');
			
		if (!$button.find('span span').length)
			$button.find('span').wrap('<span/>');
		
		$.ajax({
			  url: $this.attr('action')
			, type: 'post'
			, data: $this.serialize()
			, global: false
			, success: function(data, status, xhr) {
				// we are expecting json back so we can do the redirect
				var   $html
					, $scrollTo = $('.field-with-errors:first').parents('.fieldset')
					, $container = $('#loading-container');
					
				if (typeof data == 'object')
				{
					$.ajax({url: data.redirect});
				}
				else
				{
					$html = $(data);
					$container.html($html);
					if (!$scrollTo.length)
						$scrollTo = $('.field-with-errors:first').parents('.form')
					$.scrollTo($scrollTo, 300);
				}
			}
		});
	
		return false;
	});

})(jQuery);