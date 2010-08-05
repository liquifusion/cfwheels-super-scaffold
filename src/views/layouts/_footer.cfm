<cfoutput>
	<p>
		&copy; 
		<cfif application.wheels.scaffoldCopyrightStartYear eq Year(Now())>
			#application.wheels.scaffoldCopyrightStartYear#
		<cfelse>
			#application.wheels.scaffoldCopyrightStartYear# - #Year(Now())#
		</cfif>
		<a href="#application.wheels.scaffoldDeveloperLink#" title="#application.wheels.scaffoldDeveloper#">#application.wheels.scaffoldDeveloper#</a>
		- All rights reserved.
	</p>
</cfoutput>