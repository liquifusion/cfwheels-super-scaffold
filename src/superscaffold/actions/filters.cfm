<cffunction name="$verifySessionExists" access="public" output="false" returntype="boolean" mixin="controller">
	<cfargument name="params" type="struct" required="false" default="#variables.params#" />
	<cfscript>
		var loc = { user = sessionCache("user"), params = arguments.params };
		
		if (!StructKeyExists(loc, "user") || !IsObject(loc.user) || loc.user.isNew())
		{
			if (!flashKeyExists("error"))
				flashInsert(error="Please login and we'll send you right along.");
			
			if (arguments.params.controller == "admin")
				arguments.params.controller = "";
			
			scaffoldRedirectTo(controller="sessions", action="new", params="return=#URLFor(argumentCollection=params)#");
		}
	</cfscript>
	<cfreturn true />
</cffunction>

<cffunction name="$verifyScaffoldAccess" access="public" output="false" returntype="boolean" mixin="controller">
	<cfscript>
		// make sure the action is listed
		if (!ListFindNoCase($getSetting(name="actions"), params.action))
			params.action = "pageNotFound";
		
		// make sure that this users role is allowed access
		if(!ListFindNoCase($getSetting(name="roles", sectionName=params.action), "all") && !ListFindNoCase($getSetting(name="roles", sectionName=params.action), sessionCache("user").role.title))
			params.action = "pageNotFound";
	</cfscript>
	<cfreturn true />
</cffunction>

<cffunction name="$defaultRequiredParams" access="public" output="false" returntype="boolean" mixin="controller">
	<cfparam name="params.search" default="" />
	<cfparam name="params.p" default="1" />
	<cfparam name="params.s" default="#$getSetting(name='sorting', sectionName='list')#" />
	<cfparam name="params.d" default="#$getSetting(name='sortingDirection', sectionName='list')#" />
	<cfparam name="params.returnParams" default="" />
	<cfreturn true />
</cffunction>

<cffunction name="$setModel" access="public" output="false" returntype="boolean" mixin="controller">
	<cfscript>
		modelName = $getSetting(name="modelName");
		modelObject = model(modelName);
		
		if (StructKeyExists(params, "association"))
		{
			associationName = singularize(params.association);
			associationObject = model(associationName);
		}
		
		if (params.action == "nested")
			properties = associationObject.displayPropertiesFor("list");
		else
			properties = modelObject.displayPropertiesFor(params.action);
	</cfscript>
	<cfreturn true />
</cffunction>

<cffunction name="$setReturnParams" access="public" output="false" returntype="boolean" mixin="controller">
	<cfargument name="params" type="struct" required="false" default="#variables.params#" />
	<cfscript>
		var loc = {};
		loc.returnParams = sessionCache("returnParams");
		
		if (!StructKeyExists(loc, "returnParams"))
			loc.returnParams = "";
			
		if (ListFindNoCase("index,list", arguments.params.action))
			loc.returnParams = "";
			
		if (arguments.params.action == "nested")
		{
			loc.currentUrl = scaffoldURLFor(argumentCollection=arguments.params);
			loc.position = ListFindNoCase(loc.returnParams, loc.currentUrl);
			
			if (loc.position gt 1)
				for (loc.i = loc.position - 1; loc.i gte 1; loc.i--)
					loc.returnParams = ListDeleteAt(loc.returnParams, loc.i);
			else if (loc.position == 0)
				loc.returnParams = ListPrepend(loc.returnParams, loc.currentUrl);
		}
		
		sessionCache("returnParams", loc.returnParams);
		arguments.params.returnParams = loc.returnParams;
	</cfscript>
	<cfreturn true />
</cffunction>

<cffunction name="$setBreadCrumbs" access="public" output="false" returntype="boolean" mixin="controller">
	<cfargument name="params" type="struct" required="false" default="#variables.params#" />
	<cfscript>
		var loc = {};
		loc.params = Duplicate(arguments.params);
		StructDelete(loc.params, "action", false);
		loc.breadCrumbs = sessionCache("breadCrumbs");
		loc.returnParams = arguments.params.returnParams;
		loc.previousController = sessionCache("breadCrumbsController");
		
		if (!StructKeyExists(loc, "previousController"))
			loc.previousController = loc.params.controller;
		
		if (!StructKeyExists(loc, "breadCrumbs"))
			loc.breadCrumbs = [ 
				  { text = $getSetting(name="label", sectionName="list"), href = scaffoldURLFor(argumentCollection=loc.params) } 
			];
			
		if (arguments.params.action == "index")
			loc.breadCrumbs = [];
			
		if (arguments.params.action == "list" || (loc.previousController != loc.params.controller && !ListLen(loc.returnParams) && arguments.params.action != "index"))
			loc.breadCrumbs = [ 
				  { text = $getSetting(name="label", sectionName="list"), href = scaffoldURLFor(argumentCollection=arguments.params) } 
			];
		
		if (ListLen(loc.returnParams))
		{
			loc.currentUrl = scaffoldURLFor(argumentCollection=arguments.params);
			// add our nestings to the breadcrumbs
			for (loc.i = ListLen(loc.returnParams); loc.i gte 1; loc.i--)
			{
				loc.returnParam = ListGetAt(loc.returnParams, loc.i);
				loc.a = { text = humanize(ListLast(loc.returnParam, "/")), href = loc.returnParam };
				ArrayAppend(loc.breadCrumbs, loc.a);
			}
		}
		
		if (!ListFindNoCase("nested,list,index", arguments.params.action))
		{
			loc.text = humanize(arguments.params.action);
			loc.a = { text = loc.text , href = scaffoldURLFor(argumentCollection=arguments.params) };
			ArrayAppend(loc.breadCrumbs, loc.a);
		}
		
		params.breadCrumbs = loc.breadCrumbs;
		
		// only keep the bottom 2 for the session
		loc.sessionArray = [];
		for (loc.i = 1; loc.i lte 1; loc.i++)
			if (ArrayLen(loc.breadCrumbs) gte loc.i)
				loc.sessionArray[loc.i] = loc.breadCrumbs[loc.i]; 
		
		sessionCache("breadCrumbs", loc.sessionArray);
		sessionCache("breadCrumbsController", loc.params.controller);
	</cfscript>
	<cfreturn true />
</cffunction>


