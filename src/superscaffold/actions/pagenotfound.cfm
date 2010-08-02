<cffunction name="doPageNotFound" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		$header(statusCode=404, statustext="Not Found");
	</cfscript>
</cffunction>