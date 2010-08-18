<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			scaffoldLite(label="Application", actions="list,save", formats="html");
		</cfscript>
	</cffunction>
	
	<cffunction name="list" access="public" output="false" returntype="void">
		<cfscript>
			environments = ["design", "development", "testing", "maintenance", "production"];
		</cfscript>
	</cffunction>
	
	<cffunction name="save" output="false" access="public">
		<cfscript>
			var args = {};
		
			args.output = '<cfset set(environment="#params.environment#") />';
			args.addNewLine = false;
			args.file = getDirectoryFromPath(getBaseTemplatePath()) & "/" & application.wheels.configPath & "/environment.cfm";
			args.action = "write";
			
			$file(argumentCollection=args, mode="775");
			
			flashInsert(success="The environment has been successfully changed.");
			scaffoldRedirectTo(params="reload=true&amp;password=#get('reloadPassword')#");
		</cfscript>
	</cffunction>
	
</cfcomponent>