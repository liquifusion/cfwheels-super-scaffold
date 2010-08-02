<cfoutput>
	<div class="search">
		#scaffoldStartFormTag()#
			#includePartial(partial="search")#
			#scaffoldLinkTo(id="clear-search", text="reset", title="reset")#
		#endFormTag()#
	</div>
</cfoutput>