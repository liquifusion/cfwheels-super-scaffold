<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			scaffoldLite(label="", actions="index", formats="html");
		</cfscript>
	</cffunction>
	
	<cffunction name="index" access="public" output="false" returntype="void">
	</cffunction>
	
</cfcomponent>