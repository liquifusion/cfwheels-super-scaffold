<cffunction name="scaffoldDateSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfscript>
		$args(name="scaffoldDateSelect", args=arguments);
		arguments.$functionName = "dateSelect";
		$scaffoldDescription(args=arguments);
	</cfscript>
	<cfreturn $dateOrTimeSelect(argumentCollection=arguments)>
</cffunction>

<cffunction name="scaffoldTimeSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfscript>
		$args(name="scaffoldTimeSelect", args=arguments);
		arguments.$functionName = "timeSelect";
		$scaffoldDescription(args=arguments);
	</cfscript>
	<cfreturn $dateOrTimeSelect(argumentCollection=arguments)>
</cffunction>

<cffunction name="scaffoldDateTimeSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfscript>
		$args(name="scaffoldDateTimeSelect", reserved="name", args=arguments);
		arguments.name = $tagName(arguments.objectName, arguments.property);
		arguments.$functionName = "dateTimeSelect";
		$scaffoldDescription(args=arguments);
	</cfscript>
	<cfreturn dateTimeSelectTags(argumentCollection=arguments)>
</cffunction>