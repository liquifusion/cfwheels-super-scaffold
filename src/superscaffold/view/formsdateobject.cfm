<cffunction name="scaffoldDateSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfscript>
		$args(name="scaffoldDateSelect", args=arguments);
	</cfscript>
	<cfreturn dateSelect(argumentCollection=arguments)>
</cffunction>

<cffunction name="scaffoldTimeSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfscript>
		$args(name="scaffoldTimeSelect", args=arguments);
	</cfscript>
	<cfreturn timeSelect(argumentCollection=arguments)>
</cffunction>

<cffunction name="scaffoldDateTimeSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfscript>
		$args(name="scaffoldDateTimeSelect", args=arguments);
	</cfscript>
	<cfreturn dateTimeSelect(argumentCollection=arguments)>
</cffunction>