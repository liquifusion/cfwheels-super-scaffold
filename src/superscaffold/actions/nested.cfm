<cffunction name="doNested" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		var args = { handle = "list", returnAs = "objects" };
		
		// set our pagination data if we need it
		if ($doPagination())
		{
			args.perPage = $getSetting(name="paginationPerPage", sectionName="list");
			args.page = (StructKeyExists(params, "p") && IsNumeric(params.p)) ? params.p : 1;
		}
		
		args.where = $createWhereConditions(model=associationObject);
		
		// get our base model
		variables[modelName] = modelObject.findByKey(key=params.key);
		
		// get only the association records for the base model
		if (Len(args.where))
			args.where &= " AND #modelObject.$foreignKeyForAssociation(params.association)# = #variables[modelName].id#";
		else
			args.where = "#modelObject.$foreignKeyForAssociation(params.association)# = #variables[modelName].id#";
		
		variables[modelName][params.association] = associationObject.scaffoldFindAll(argumentCollection=args);
		renderWith(variables[modelName]);
	</cfscript>
</cffunction>