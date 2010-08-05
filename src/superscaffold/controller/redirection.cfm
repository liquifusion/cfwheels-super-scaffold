<cffunction name="scaffoldRedirectTo" returntype="void" access="public" output="false" mixin="controller">
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="controller" type="string" required="false" default="#variables.params.controller#" />
	<cfscript>
		var loc = { "statusCode" = 278 };
	
		if (StructKeyExists(arguments, "action") && arguments.action == "list")
			StructDelete(arguments, "action");
		
		// if we have an ajax request, return a json response in the body for us to use in jquery
		if (isAjax())
		{
			if (StructKeyExists(variables.params, "return"))
				loc["redirect"] = variables.params.return;
			else
				loc["redirect"] = scaffoldURLFor(argumentCollection=arguments);
			
			$header(name="content-type", value="text/json" , charset="utf-8");
			renderText(SerializeJSON(loc));
			flashKeep();
			return;
		}
		
		if (StructKeyExists(variables.params, "return"))
			$location(url=variables.params.return, addtoken=false);
	</cfscript>
	<cfreturn redirectTo(argumentCollection=arguments) />
</cffunction>
