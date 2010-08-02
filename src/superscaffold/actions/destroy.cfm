<cffunction name="doDestroy" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		variables[modelName] = modelObject.findByKey(key=params.key);
		
		if (variables[modelName].delete())
			flashInsert(success="The #modelName# was deleted successfully.");
		else
			flashInsert(error="There was an error deleting the #modelName#.");
		
		scaffoldRedirectTo(action=$getSetting(name="returnToAction", sectionName="delete"));
	</cfscript>
</cffunction>