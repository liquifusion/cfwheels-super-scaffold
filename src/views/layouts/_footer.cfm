<cfoutput>
	<p>
		&copy; 
		<cfif application.superScaffold.copyrightStartYear eq Year(Now())>
			#application.superScaffold.copyrightStartYear#
		<cfelse>
			#application.superScaffold.copyrightStartYear# - #Year(Now())#
		</cfif>
		<a href="#application.superScaffold.developerLink#" title="#application.superScaffold.developer#">#application.superScaffold.developer#</a>
		- All rights reserved.
	</p>
</cfoutput>