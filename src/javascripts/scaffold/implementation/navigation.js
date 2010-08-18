;(function($) {
	
	// navigation setup with superfish
	$('#navigation ul.clearfix').livequery(function() {
										   
		var $this = $(this);
		$this.superfish({
			  pathClass: 'active'
			, pathLevels: 1
			, delay: 1000
			, autoArrows: false
			, dropShadows: false
		});
	});

})(jQuery);




