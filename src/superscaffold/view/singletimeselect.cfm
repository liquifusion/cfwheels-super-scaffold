<cffunction name="scaffoldSingleTimeSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfscript>
		$args(name="scaffoldSingleTimeSelect", args=arguments);
		arguments.$functionName = "timeSelect";
		$scaffoldDescription(args=arguments);
	</cfscript>
	<cfreturn $dateOrTimeSelect(argumentCollection=arguments)>
</cffunction>