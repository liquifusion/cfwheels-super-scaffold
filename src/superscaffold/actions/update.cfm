<cffunction name="doUpdate" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		// we don't use our scaffoldFindByKey here as the edit form 
		// should be passing through everything we need to save
		variables[modelName] = modelObject.findByKey(key=params[modelName].id);
		
		variables[modelName].setProperties(property=params[modelName]);
		
		$executeScaffoldingCallback(type="beforeUpdate", object=variables[modelName]);
		
		if (variables[modelName].update())
		{
			$executeScaffoldingCallback(type="afterUpdate", object=variables[modelName]);
		
			flashInsert(success="The #modelName# was updated successfully.");
			scaffoldRedirectTo(action=$getSetting(name="returnToAction", sectionName="update"));
		}
		else
		{
			if (ArrayLen(variables[modelName].allErrors()) gt 1)
				flashInsert(error="There were errors updating the #modelName#.");
			else
				flashInsert(error="There was an error updating the #modelName#.");
			$loadDataForProperties(properties=properties);
			renderWith(object=variables[modelName], template="edit");
		}
	</cfscript>
</cffunction>