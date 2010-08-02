<cffunction name="doUpdate" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		variables[modelName] = modelObject.scaffoldFindByKey(key=params[modelName].id);
		
		if (variables[modelName].update(properties=params[modelName]))
		{
			flashInsert(success="The #modelName# was updated successfully.");
			scaffoldRedirectTo(action=$getSetting(name="returnToAction", sectionName="update"));
		}
		else
		{
			if (ArrayLen(variables[modelName].allErrors()) gt 1)
				flashInsert(error="There were errors updating the #modelName#.");
			else
				flashInsert(error="There was an errors updating the #modelName#.");
			$loadDataForProperties(properties=properties);
			renderWith(object=variables[modelName], template="edit");
		}
	</cfscript>
</cffunction>