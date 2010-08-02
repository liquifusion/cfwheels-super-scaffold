<cffunction name="$verifyScaffoldAccess" access="public" output="false" returntype="boolean" mixin="controller">
	<cfscript>
		if (params.action == "index" && !ListFindNoCase($getSetting(name="actions"), params.action))
			params.action = "pageNotFound";
	</cfscript>
	<cfreturn true />
</cffunction>

<cffunction name="$defaultRequiredParams" access="public" output="false" returntype="boolean" mixin="controller">
	<cfparam name="params.search" default="" />
	<cfparam name="params.p" default="1" />
	<cfparam name="params.s" default="#$getSetting(name='sorting', sectionName='list')#" />
	<cfparam name="params.d" default="#$getSetting(name='sortingDirection', sectionName='list')#" />
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


