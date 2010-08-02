<cffunction name="doNew" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		onlyProvides("html");
		variables[modelName] = modelObject.scaffoldNew();
		if (StructKeyExists(params, "association") && StructKeyExists(params, "key"))
			variables[modelName][modelObject.$foreignKeyForAssociation(associationName)] = params.key;
		$loadDataForProperties(properties=properties);
		renderWith(variables[modelName]);
	</cfscript>
</cffunction>