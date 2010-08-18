<cffunction name="scaffold" access="public" output="false" returntype="void" mixin="controller">
	<cfargument name="modelName" type="string" required="true" hint="Model to use with this super scaffold controller" />
	<cfargument name="label" type="string" required="false" hint="the default label for this area of the admin. defaults to the pluralized model name" />
	<cfargument name="actions" type="string" required="false" hint="Define what actions are available from the list. Only actions present in the list will be available." />
	<cfargument name="formats" type="string" required="false" hint="I define what formats can be requested from this super scaffold controller." />
	<cfscript>
		var loc = {};
		$args(args=arguments, name="scaffold");
		arguments.label = (StructKeyExists(arguments, "label")) ? arguments.label : capitalize(humanize(pluralize(arguments.modelName)));
		variables.$class.superScaffold = {};
		
		// translate actions
		arguments.actions = ListAppend(arguments.actions, "pagenotfound,accessdenied");
		if (ListFindNoCase(arguments.actions, "create"))
			arguments.actions = ListAppend(arguments.actions, "new");
		if (ListFindNoCase(arguments.actions, "update"))
			arguments.actions = ListAppend(arguments.actions, "edit");	
		if (ListFindNoCase(arguments.actions, "delete"))
			arguments.actions = ListAppend(arguments.actions, "destroy");
		
		// clean all of our lists and add them to the class data
		for (loc.item in arguments)
			if (StructKeyExists(arguments, loc.item))
				variables.$class.superScaffold[loc.item] = $listClean(arguments[loc.item]);

		// set all of our other defaults
		scaffoldList();
		scaffoldView();
		scaffoldSearch();
		scaffoldCreate();
		scaffoldUpdate();
		scaffoldDelete();
		scaffoldRoles();
		
		filters(through="$verifySessionExists,$setModel,$defaultRequiredParams,$setReturnParams,$setBreadCrumbs");
		filters(through="$verifyScaffoldAccess", except="badRequest,pageNotFound");
		
		// setup our default layout for all super scaffold admin areas
		usesLayout(template="/layouts/default", ajax="/layouts/default.ajax", useDefault=false);
		
		// setup our provides plugin
		provides(formats=arguments.formats);
	</cfscript>
</cffunction>

<cffunction name="scaffoldLite" access="public" output="false" returntype="void" mixin="controller">
	<cfargument name="label" type="string" required="true" hint="the default label for this area of the admin. defaults to the pluralized model name" />
	<cfargument name="actions" type="string" required="false" hint="Define what actions are available from the list. Only actions present in the list will be available." />
	<cfargument name="formats" type="string" required="false" hint="I define what formats can be requested from this super scaffold controller." />
	<cfscript>
		var loc = {};
		$args(args=arguments, name="scaffoldLite");
		variables.$class.superScaffold = {};
		
		// translate actions
		arguments.actions = ListAppend(arguments.actions, "pagenotfound,accessdenied");
		if (ListFindNoCase(arguments.actions, "create"))
			arguments.actions = ListAppend(arguments.actions, "new");
		if (ListFindNoCase(arguments.actions, "update"))
			arguments.actions = ListAppend(arguments.actions, "edit");	
		if (ListFindNoCase(arguments.actions, "delete"))
			arguments.actions = ListAppend(arguments.actions, "destroy");
		
		// clean all of our lists and add them to the class data
		for (loc.item in arguments)
			if (StructKeyExists(arguments, loc.item))
				variables.$class.superScaffold[loc.item] = $listClean(arguments[loc.item]);
		
		filters(through="$verifySessionExists,$defaultRequiredParams,$setBreadCrumbs");
		
		// setup our default layout for all super scaffold admin areas
		usesLayout(template="/layouts/default", ajax="/layouts/default.ajax", useDefault=false);
		
		// setup our provides plugin
		provides(formats=arguments.formats);
	</cfscript>
</cffunction>

<cffunction name="scaffoldList" access="public" output="false" returntype="void" mixin="controller" hint="This methods should be called AFTER scaffold().">
	<cfargument name="label" type="string" required="false" hint="the label of the form. defaults to the pluralized model name" />
	<cfargument name="conditionsForList" type="string" required="false" hint="a controller method name that will return a string of conditions to use in the where clause when displaying the list." />
	<cfargument name="paginationEnabled" type="boolean" required="false" hint="whether or not to use pagination" />
	<cfargument name="paginationPerPage" type="numeric" required="false" hint="the number of items per page" />
	<cfargument name="paginationWindowSize" type="numeric" required="false" hint="the size of the pagination window." />
	<cfargument name="sorting" type="string" required="false" hint="the sorting will be performed on the primary key column(s) if one is not provided" />
	<cfargument name="sortingDirection" type="string" required="false" default="asc" hint="the direction the sort should go." />
	<cfset $setSettings(methodName="scaffoldList", sectionName="list", argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldView" access="public" output="false" returntype="void" mixin="controller" hint="This methods should be called AFTER scaffold().">
	<cfargument name="label" type="string" required="false" hint="the label of the form. defaults to the pluralized model name" />
	<cfargument name="returnToAction" type="string" required="false" hint="the name of the super scaffold action to return to if the go back link or cancel link is clicked." />
	<cfset $setSettings(methodName="scaffoldView", sectionName="view", argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldNested" access="public" output="false" returntype="void" mixin="controller" hint="This methods should be called AFTER scaffold().">
	<cfargument name="association" type="string" required="true" />
	<cfargument name="label" type="string" required="false" default="#arguments.association#" />
	<cfscript>
		var nestedAssociation = Duplicate(arguments);
		
		if (!StructKeyExists(variables.$class, "superscaffold"))
			$throw(type="Wheels.Plugins.SuperScaffold.IncorrectMethodSequence", message="Please call `scaffold()` before calling `scaffoldNested()`.");
			
		if (!StructKeyExists(variables.$class.superscaffold, "nested"))
			variables.$class.superscaffold.nested = {};
			
		if (!StructKeyExists(variables.$class.superscaffold.nested, "associations"))
			variables.$class.superscaffold.nested.associations = [];
		
		ArrayAppend(variables.$class.superscaffold.nested.associations, nestedAssociation);
	</cfscript>
</cffunction>

<cffunction name="scaffoldSearch" access="public" output="false" returntype="void" mixin="controller" hint="This methods should be called AFTER scaffold().">
	<cfargument name="textSearch" type="string" required="false" hint="the text search can be either `first`, `last` or `full`" />
	<cfset $setSettings(methodName="scaffoldShow", sectionName="search", argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldCreate" access="public" output="false" returntype="void" mixin="controller" hint="This methods should be called AFTER scaffold().">
	<cfargument name="label" type="string" required="false" hint="the label of the form. defaults to the pluralized model name" />
	<cfargument name="returnToAction" type="string" required="false" hint="the name of the super scaffold action to return to if the go back link or cancel link is clicked." />
	<cfargument name="beforeCreate" type="string" required="false" hint="name of the method to call before attempting to save a record. Useful to add in user session data before a save." />
	<cfargument name="afterCreate" type="string" required="false" hint="similar to beforeCreate, but after." />
	<cfargument name="multipart" type="boolean" required="false" hint="whether the form accepts multipart data (aka: file uploads)" />
	<cfset $setSettings(methodName="scaffoldCreate", sectionName="create", argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldUpdate" access="public" output="false" returntype="void" mixin="controller" hint="This methods should be called AFTER scaffold().">
	<cfargument name="label" type="string" required="false" hint="the label of the form. defaults to the pluralized model name" />
	<cfargument name="returnToAction" type="string" required="false" hint="the name of the super scaffold action to return to if the go back link or cancel link is clicked." />
	<cfargument name="beforeUpdate" type="string" required="false" hint="name of the method to call before attempting to save a record. Useful to add in user session data before a save." />
	<cfargument name="afterUpdate" type="string" required="false" hint="similar to beforeCreate, but after." />
	<cfargument name="multipart" type="boolean" required="false" hint="whether the form accepts multipart data (aka: file uploads)" />
	<cfset $setSettings(methodName="scaffoldUpdate", sectionName="update", argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldDelete" access="public" output="false" returntype="void" mixin="controller" hint="This methods should be called AFTER scaffold().">
	<cfargument name="returnToAction" type="string" required="false" hint="the name of the super scaffold action to return to if the go back link or cancel link is clicked." />
	<cfargument name="beforeDelete" type="string" required="false" hint="name of the method to call before attempting to delete a record. Useful to add in user session data before a save." />
	<cfset $setSettings(methodName="scaffoldDelete", sectionName="delete", argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldRoles" access="public" output="false" returntype="void" mixin="controller" hint="This method should be called AFTER scaffold().">
	<cfargument name="roles" type="string" required="false" default="" />
	<cfscript>
		var loc = { areas = "" };
		
		if (!StructKeyExists(variables.$class, "superscaffold"))
			$throw(type="Wheels.Plugins.SuperScaffold.IncorrectMethodSequence", message="Please call `scaffold()` before calling `scaffoldRoles()`.");
			
		loc.areas = $getSetting(name="actions");
		
		for (loc.i = 1; loc.i lte ListLen(loc.areas); loc.i++)
		{
			loc.area = ListGetAt(loc.areas, loc.i);
			
			if (!StructKeyExists(variables.$class.superscaffold, loc.area))
				variables.$class.superscaffold[loc.area] = {};
			
			if (StructKeyExists(arguments, loc.area))
				variables.$class.superscaffold[loc.area].roles = arguments[loc.area];
			else if (Len(arguments.roles))
				variables.$class.superscaffold[loc.area].roles = arguments.roles;
			else
				variables.$class.superscaffold[loc.area].roles = "all";
		}
	</cfscript>
</cffunction>





