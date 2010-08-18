<cfoutput>
	<p>
		#scaffoldLinkTo(text="Dashboard", controller="", class="dashboard")# <cfif ArrayLen(loc.breadcrumbs)> &gt; </cfif>
		<cfloop from="1" to="#ArrayLen(loc.breadcrumbs)#" index="loc.i">
			#scaffoldLinkTo(argumentCollection=loc.breadcrumbs[loc.i])#
			<cfif loc.i neq ArrayLen(loc.breadcrumbs)> &gt; </cfif>
		</cfloop>
	</p>
</cfoutput>