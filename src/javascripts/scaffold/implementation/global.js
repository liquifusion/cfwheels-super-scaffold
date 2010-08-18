;(function($) {
	
	// cache a couple location variables so we can do our ajax processing
	var   originalLocation = window.location
		, currentPath = window.location.pathname
		, xhrPath = window.location.pathname;
		
	$('html').addClass('enhanced');
	
	// don't cache any requests and let's default to get
	$.ajaxSetup({cache: false, type: 'get'});
	
	// jquery address has problems in chrome / safari so we aren't tracking history in that browser right now
	$(document).ajaxSend(function(event, xhr, settings) {
		var url = settings.url.replace(/\?_=\d+|\&_=\d+/g, '');
		// also don't track history if we are executing write functionality or if we are on the original page
		if (!$.browser.webkit && url != originalLocation && url.search(/create|update|destroy/) == -1) $.address.value(url);
		xhrPath = $.url.setUrl(url).attr('path');
	});
	
	$(document).ajaxError(function(event, xhr, settings) {
		if (xhr.status == 500) alert('The server returned an error.');
		else if (xhr.status == 404) alert('The URL requested could not be found.');
	});
	
	// default success handler for both same page requests and page transitions
	$(document).ajaxSuccess(function(event, xhr, settings) {
		
		var   $html
			, $container = $('#loading-container')
			, $current = $container.find('div:first')
			, duration = 250
			, $message;
			
		try
		{
			// if we get a redirect response outside of form submission
			// it most likely means that they need to log back in
			var object = $.parseJSON(xhr.responseText);
			if (typeof object == 'object') window.location = object.redirect;
			return;
		}
		catch (error)
		{
			// we have html so create a jquery object
			$html = $(xhr.responseText);
		}
		
		if (currentPath == xhrPath || xhrPath == '/')
		{
			$container.html($html);
		}
		else
		{
			if (!$.browser.msie) $html.css({opacity: .25});
			
			$container.prepend($html);
			
			$message = $('div.success,div.error,div.notice');
			
			$current
				.addClass('animate-away')
				.animate({opacity: 0, top: 1000}, { duration: duration, complete: function() { $(this).remove(); }});
				
			if (!$.browser.msie) $html.animate({opacity: 1}, {duraction: duration});
			
			if ($message.length) $.scrollTo($message.parents('.container'), duration);
			
			// set our new path for the next request
			currentPath = xhrPath;
		}
	});
	
	// do nothing for internal changes
	$.address.internalChange(function(event) {});
	
	// external changes tries to fire an event on page load so we need to not react to that first change event
	var loadComplete = false;
	
	// decide the functionality we should perform when the hashed url is changed from the browser
	$.address.externalChange(function(event) {
									  
		var url = event.value;
		
		if (url != '/')
			loadComplete = true;
		if (loadComplete)
		{
			if (url == '/')
				url = $.address.baseURL();
			$.ajax({url: url});
		}
		
		loadComplete = true;
	});
	
	// let's get the new button going with loading the form in the top of the page below heading
	$('#body .links .interface-button').live('click', function(event) {
	
		var   $this = $(this);
		
		$this.removeClass('new')
			.removeClass('edit')
			.removeClass('back')
			.removeClass('delete');
		if (!$this.find('span span').length)
			$this.find('span').wrap('<span/>');
		$.ajax({url: $this.attr('href')});
		return false;
	});
	
	$('#body .bread-crumbs a[class!=dashboard]').live('click', function(event) {
	
		var   $this = $(this);
		$this.addClass('loading');
		$.ajax({url: $this.attr('href')});
		return false;
	});

})(jQuery);




