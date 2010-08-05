<cffunction name="$generateIncludeTemplatePath" returntype="string" access="public" output="false">
	<cfargument name="$name" type="any" required="true" />
	<cfargument name="$type" type="string" required="true" />
	<cfargument name="$actionName" type="string" required="false" default="#variables.params.action#" />
	<cfargument name="$controllerName" type="string" required="false" default="#variables.params.controller#" />
	<cfargument name="$alternateBaseTemplatePath" type="string" required="false" default="#application.wheels.pluginPath#/superscaffold/views" />
	<cfscript>
		var loc = {};
		var originalGenerateIncludeTemplatePath = core.$generateIncludeTemplatePath;
			
		if (Len(application.wheels.webPath) && application.wheels.webPath != "/")
			arguments.$alternateBaseTemplatePath = application.wheels.webPath & "/" & arguments.$alternateBaseTemplatePath;
			
			
		if (StructKeyExists(arguments, "$template") && Find("/", arguments.$template))
		{
			arguments.$name = ListLast(arguments.$name, "/");
			arguments.$template = ListLast(arguments.$template, "/");
		}
		
		loc.templatePath = "";
		loc.action = arguments.$actionName;
		loc.controller = arguments.$controllerName;

		// get rid of the extra arguments
		StructDelete(arguments, "$actionName");
		
		if (StructKeyExists(variables.$class, "superScaffold"))
			if (StructKeyExists(variables.$class.superScaffold, "views"))
				if (StructKeyExists(variables.$class.superScaffold.views, loc.controller))
					if (StructKeyExists(variables.$class.superScaffold.views[loc.controller], loc.action))
						if (StructKeyExists(variables.$class.superScaffold.views[loc.controller][loc.action], arguments.$name))
							loc.templatePath = variables.$class.superScaffold.views[loc.controller][loc.action][arguments.$name];
		
		if (!Len(loc.templatePath))
		{
			loc.templatePath = originalGenerateIncludeTemplatePath(argumentCollection=arguments);
			if (!FileExists(ExpandPath(loc.templatePath)))
				loc.templatePath = originalGenerateIncludeTemplatePath($name=arguments.$name, $type=arguments.$type, $controllerName=arguments.$controllerName, $baseTemplatePath=arguments.$alternateBaseTemplatePath);
			if (!FileExists(ExpandPath(loc.templatePath)))
				loc.templatePath = originalGenerateIncludeTemplatePath($name=arguments.$name, $type=arguments.$type, $controllerName="templates", $baseTemplatePath=arguments.$alternateBaseTemplatePath);
			
			// TODO: cache the path if we are in maintenance, testing or production
//			if (ListFindNoCase("maintenance,testing,production", application.wheels.environment))
//			{
//				if (FindNoCase("admin", loc.controller) || FindNoCase("system", loc.controller) || loc.action == "sitenotfound" || !StructKeyExists(loc, "accountStringId"))
//					application.superScaffold[loc.controller][loc.action][arguments.$name] = loc.templatePath;
//				else
//					application.superScaffold[loc.controller][loc.action][loc.accountStringId][arguments.$name] = loc.templatePath;
//			}
		}
	</cfscript>
	<cfreturn loc.templatePath />
</cffunction>