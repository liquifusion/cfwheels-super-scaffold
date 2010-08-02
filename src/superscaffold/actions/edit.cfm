<cffunction name="doEdit" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		onlyProvides("html");
		variables[modelName] = modelObject.scaffoldFindByKey(key=params.key);
		$loadDataForProperties(properties=properties);
		renderWith(variables[modelName]);
	</cfscript>
</cffunction>