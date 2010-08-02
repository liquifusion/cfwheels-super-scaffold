<cfoutput>
	<cfif $doPagination()>
		#paginationLinks(
			  windowSize=$getSetting(name="paginationWindowSize", sectionName="list")
			, showSinglePage = false
			, name = "p"
			, handle = "list"
			, alwaysShowAnchors = true
			, linkToCurrentPage = true
			, classForCurrent = "active"
			, prepend = "<div class=""pagination clearfix""><p>"
			, append = "</p></div>"
			, route = "superScaffold"
			, controller = params.controller
			, params = buildPagiationParams()
			, anchorDivider = "<span>...</span>")#
	</cfif>
</cfoutput>