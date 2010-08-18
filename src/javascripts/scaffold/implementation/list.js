;(function($) {

	// setup a list tr to change the background on hover
	$('#body .listings table tbody tr').live('mouseover mouseout', function(event) {
	
		var $this = $(this)
			, $td = $this.find('td.action-links')
			, $viewLink = $td.find('a.view');
		
		if (!$viewLink.length)
			return true;
		if (event.type == 'mouseover') { $this.addClass('hover'); }
		else $this.removeClass('hover');
	});
	
	// setup a list tr that when clicked will show the view screen
	$('#body .listings table tbody tr').live('click', function(event) {
	
		var   $this = $(this)
			, $td = $this.find('td.action-links')
			, $viewLink = $td.find('a.view');
		
		// show the loader
		if (!$viewLink.length)
			return true;
		$td.addClass('loading');
		$.ajax({url: $viewLink.attr('href')});
		return false;
	});
	
	// let's get the sorting working with some xhr requests
	$('#body .listings table thead tr th a').live('click', function(event) {
	
		var   $this = $(this)
			, $th = $this.parent();
		
		// show the loader
		$th.addClass('loading');
		$.ajax({url: $this.attr('href')});
		return false;
	});
	
	// pagination should also work with xhr requests
	$('#body .pagination p a').live('click', function(event) {
	
		var   $this = $(this);
		
		$this.addClass('loading').html('&nbsp;');
		$.ajax({url: $this.attr('href')});
		return false;
	});
	
	// searching should also work with xhr requests
	$('#body .search form').live('submit', function(event) {
	
		var   $this = $(this)
			, $input = $this.find('input.text')
			, url = $this.attr('action') + '?' + $this.serialize();
			
		$input.addClass('loading');
		$.ajax({url: url});
		return false;
	});
	
	// the reset link should also work with xhr requests
	$('#body .search #clear-search').live('click', function(event) {
	
		var   $this = $(this);
			
		$this.addClass('loading');
		$.ajax({url: $this.attr('href')});
		return false;
	});
	
	// hook up all of the list links to create xhr requests
	$('#body .listings table tbody tr td.action-links a').live('click', function(event) {
	
		var   $this = $(this)
			, $td = $this.parent();
		
		$td.addClass('loading');
		$.ajax({url: $this.attr('href')});
		return false;
	});
	
})(jQuery);