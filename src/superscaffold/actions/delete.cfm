<cffunction name="doDelete" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		onlyProvides("html");
		variables[modelName] = modelObject.scaffoldFindByKey(key=params.key);
		renderWith(variables[modelName]);
	</cfscript>
</cffunction>