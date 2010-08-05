<cffunction name="doDelete" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		onlyProvides("html");
		variables[modelName] = modelObject.scaffoldFindByKey(key=params.key);
		
		if (!IsObject(variables[modelName]))
			scaffoldRedirectTo(action=$getSetting(name="returnToAction", sectionName="delete"));
		else
			renderWith(variables[modelName]);
	</cfscript>
</cffunction>