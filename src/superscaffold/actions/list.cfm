<cffunction name="doList" access="public" output="false" returntype="void" mixin="controller">
	<cfset var args = { handle = "list", returnAs = "objects" }>
	<cfparam name="params.page" default="1" />
	<cfscript>
		// set our pagination data if we need it
		if ($doPagination())
		{
			args.perPage = $getSetting(name="paginationPerPage", sectionName="list");
			args.page = 1;
			if (StructKeyExists(params, "p") && IsNumeric(params.p))
			{
				args.page = params.p;
			}
		}
			
		// add in our search conditions and order clause
		args.where = $createWhereConditions(model=modelObject);
		args.order = $createOrderClause(model=modelObject);
		list = modelObject.scaffoldFindAll(argumentCollection=args);
		renderWith(list);
	</cfscript>
</cffunction>