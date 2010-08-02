<cfoutput>
	<div class="search">
		#scaffoldStartFormTag(action="nested", key=params.key, association=params.association)#
			#includePartial(partial="search")#
			#scaffoldLinkTo(action="nested", key=params.key, association=params.association, id="clear-search", text="reset", title="reset")#
		#endFormTag()#
	</div>
</cfoutput>