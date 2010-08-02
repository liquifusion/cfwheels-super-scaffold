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
		var returnValue = false;
		if ($getSetting(name="paginationEnabled", sectionName="list") && (!StructKeyExists(params, "format") || params.format == "html"))
			returnValue = true;
	</cfscript>
	<cfreturn returnValue />
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
	<cfscript>
		params.s = (params.s == "primaryKeys") ? model.primaryKey() : params.s;
	</cfscript>
	<cfreturn params.s & " " & params.d />
</cffunction>

