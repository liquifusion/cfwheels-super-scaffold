<cffunction name="doCreate" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		variables[modelName] = modelObject.new();
		variables[modelName].setProperties(properties=params[modelName], $useFilterLists=false);
		
		$executeScaffoldingCallback(type="beforeCreate", object=variables[modelName]);
		
		if (variables[modelName].save())
		{
			$executeScaffoldingCallback(type="afterCreate", object=variables[modelName]);
		
			flashInsert(success="The #modelName# was created successfully.");
			scaffoldRedirectTo(action=$getSetting(name="returnToAction", sectionName="create"));
		}
		else
		{
			if (ArrayLen(variables[modelName].allErrors()) gt 1)
				flashInsert(error="There were errors creating the #modelName#.");
			else
				flashInsert(error="There was an error creating the #modelName#.");
			$loadDataForProperties(properties=properties);
			renderWith(object=variables[modelName], template="new");
		}
	</cfscript>
</cffunction>