<cfoutput>
	<div>
		<div class="message-container">
			#flashShow()#
		</div>
		<div class="bread-crumbs">
			#includePartial(partial="/layouts/breadcrumbs", breadcrumbs=params.breadcrumbs, cache=true)#
		</div>
		#includeContent()#
	</div>
</cfoutput>