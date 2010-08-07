<cffunction name="scaffoldRedirectTo" returntype="void" access="public" output="false" mixin="controller">
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="controller" type="string" required="false" default="#variables.$class.name#" />
	<cfscript>
		var loc = { "statusCode" = 278 };
	
		if (StructKeyExists(arguments, "action") && arguments.action == "list")
			StructDelete(arguments, "action");
			
		loc["redirect"] = URLFor(argumentCollection=arguments);
			
		// find out where we are going
		if (StructKeyExists(variables.params, "returnParams") && ListLen(variables.params.returnParams))
			loc.redirect = ListFirst(variables.params.returnParams);
		
		// if we have an ajax request, return a json response in the body for us to use in jquery
		if (isAjax())
		{
			$header(name="content-type", value="text/json" , charset="utf-8");
			renderText(SerializeJSON(loc));
			flashKeep();
			return;
		}
		
		$location(url=loc.redirect, addtoken=false);
	</cfscript>
	<cfreturn />
</cffunction>
