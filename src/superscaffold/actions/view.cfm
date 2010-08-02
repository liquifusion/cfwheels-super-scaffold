<cffunction name="doView" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		variables[modelName] = modelObject.scaffoldFindByKey(key=params.key);
		renderWith(variables[modelName]);
	</cfscript>
</cffunction>