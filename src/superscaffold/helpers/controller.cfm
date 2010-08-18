<cffunction name="$executeScaffoldingCallback" access="public" output="false" returntype="void" mixin="controller">
	<cfargument name="type" type="string" required="true" />
	<cfargument name="object" type="component" required="true" />
	<cfargument name="action" type="string" required="false" default="#variables.params.action#" />
	<cfscript>
		var callbackMethod = false;
		argments.action = (arguments.action == "destroy") ? "delete" : arguments.action;
		
		callbackMethod = $getSetting(name=arguments.type, sectionName=arguments.action, searchRoot=false);
		if (callbackMethod != false && StructKeyExists(this, callbackMethod))
			$invoke(method=callbackMethod, object=arguments.object);
	</cfscript>
</cffunction>

<cffunction name="$loadDataForProperties" access="public" output="false" returntype="void" mixin="controller">
	<cfargument name="properties" type="array" required="true" />
	<cfscript>
		var loc = {};
		for (loc.i = 1; loc.i lte ArrayLen(arguments.properties); loc.i++)
		{
			loc.property = arguments.properties[loc.i];
			
			if (StructKeyExists(loc.property, "type") && loc.property.type eq "belongsTo")
			{
				loc.sortBy = model(loc.property.property).primaryKey();
				if (StructKeyExists(loc.property, "sortBy"))
					loc.sortBy = loc.property.sortBy;
				variables[pluralize(loc.property.property)] = model(loc.property.property).findAll(order=loc.sortBy);
			}
		}	
	</cfscript>
</cffunction>

<cffunction name="$doPagination" access="public" output="false" returntype="boolean" mixin="controller">
	<cfscript>
		var loc = { returnValue = false, paginationEnabled = $getSetting(name="paginationEnabled", sectionName="list") };
		if (IsBoolean(loc.paginationEnabled) && loc.paginationEnabled && (!StructKeyExists(params, "format") || params.format == "html"))
			loc.returnValue = true;
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="$createWhereConditions" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="model" type="component" required="true" />
	<cfargument name="action" type="string" required="false" default="#variables.params.action#" />
	<cfscript>
		var loc = { where = "" };
		
		if (arguments.action eq "list")
		{
			loc.conditionsForList = $getSetting(name="conditionsForList", sectionName="list", searchRoot=false);
			
			// set our where clause if the developer has provided a method to return the where clause
			if (Len(loc.conditionsForList) && StructKeyExists(this, loc.conditionsForList))
				loc.where = $invoke(componentReference=this, method=loc.conditionsForList);
		}
		
		if (Len(params.search))
		{
			// get our properties for the search
			loc.properties = arguments.model.searchProperties();
			loc.textSearch = $getSetting(name="textSearch", sectionName="search", searchRoot=false);
			loc.search = "";
		
			for (loc.i = 1; loc.i lte ListLen(loc.properties); loc.i++)
			{
				loc.property = ListGetAt(loc.properties, loc.i);
				
				if (Len(loc.search))
					loc.search &= " OR ";
				
				switch (loc.textSearch)
				{
					case "first":
						loc.search &= "#loc.property# LIKE '#params.search#%'";
						break;
					case "last":
						loc.search &= "#loc.property# LIKE '%#params.search#'";
						break;
					default:
						loc.search &= "#loc.property# LIKE '%#params.search#%'";
				}
			}
			
			if (Len(loc.search))
			{
				if (Len(loc.where))
					loc.where &= " AND (#loc.search#)";
				else
					loc.where = "(#loc.search#)";
			}
		}
	</cfscript>
	<cfreturn loc.where />
</cffunction>

<cffunction name="$createOrderClause" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="model" type="component" required="true" />
	<cfscript>
		params.s = (params.s == "primaryKeys") ? arguments.model.primaryKey() : params.s;
	</cfscript>
	<cfreturn params.s & " " & params.d />
</cffunction>

<cffunction name="$controllerName" access="public" output="false" returntype="string" mixin="controller">
	<cfreturn variables.$class.name />
</cffunction>

