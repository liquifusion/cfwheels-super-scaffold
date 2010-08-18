;(function($) {
	
	// navigation setup with superfish
	$('#body .message-container div.success,#body .message-container div.notice,#body .message-container div.error').live('click', function(event) {
	
		var   $this = $(this)
			, $container = $this.parent();
		
		$container.slideUp(300, function() { $(this).remove(); });
		
		return false;
	});

})(jQuery);




