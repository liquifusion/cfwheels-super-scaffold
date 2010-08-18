<cffunction name="doView" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		variables[modelName] = modelObject.scaffoldFindByKey(key=params.key, addNewAssociationObjects=false);
		renderWith(variables[modelName]);
	</cfscript>
</cffunction>