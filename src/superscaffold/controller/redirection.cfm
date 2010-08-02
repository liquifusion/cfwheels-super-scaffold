<cffunction name="scaffoldRedirectTo" returntype="void" access="public" output="false" mixin="controller">
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="controller" type="string" required="false" default="#variables.params.controller#" />
	<cfif StructKeyExists(arguments, "action") and arguments.action eq "list">
		<cfset StructDelete(arguments, "action") />
	</cfif>
	<cfif StructKeyExists(params, "return")>
		<cflocation url="#params.return#" addtoken="false" />
	</cfif>
	<cfreturn redirectTo(argumentCollection=arguments) />
</cffunction>
