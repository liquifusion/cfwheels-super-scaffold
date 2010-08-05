<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			filters(through="$verifySessionExists");
			usesLayout(template="/layouts/default", useDefault=false);
		</cfscript>
	</cffunction>
	
	<cffunction name="index" access="public" output="false" returntype="void">
	</cffunction>
	
</cfcomponent>