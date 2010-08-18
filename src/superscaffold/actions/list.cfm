<cffunction name="doList" access="public" output="false" returntype="void" mixin="controller">
	<cfparam name="params.page" default="1" />
	<cfscript>
		var args = { handle = "list", returnAs = "objects" };
		
		// set our pagination data if we need it
		if ($doPagination())
		{
			args.perPage = $getSetting(name="paginationPerPage", sectionName="list");
			args.page = (StructKeyExists(params, "p") && IsNumeric(params.p)) ? params.p : 1;
		}
			
		// add in our search conditions and order clause
		args.where = $createWhereConditions(model=modelObject);
		args.order = $createOrderClause(model=modelObject);
		list = modelObject.scaffoldFindAll(argumentCollection=args);
		renderWith(list);
	</cfscript>
</cffunction>