<cffunction name="$getSetting" access="public" output="false" returntype="any" mixin="controller">
	<cfargument name="name" type="string" required="true" />
	<cfargument name="sectionName" type="string" required="false" />
	<cfargument name="searchRoot" type="boolean" required="false" default="true" />
	<cfscript>
		if (StructKeyExists(arguments, "sectionName") && StructKeyExists(variables.$class.superScaffold, arguments.sectionName) && IsStruct(variables.$class.superScaffold[arguments.sectionName]) && StructKeyExists(variables.$class.superScaffold[arguments.sectionName], arguments.name))
			return variables.$class.superScaffold[arguments.sectionName][arguments.name];
		
		if (StructKeyExists(variables.$class.superScaffold, arguments.name) && arguments.searchRoot)
			return variables.$class.superScaffold[arguments.name];
	</cfscript>
	<cfreturn "" />
</cffunction>
<!---
<cffunction name="$getNestedSetting" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="name" type="string" required="true" />
	<cfargument name="association" type="string" required="true" />
	<cfscript>
		var loc = {};
		if (StructKeyExists(variables.$class.superScaffold, "nested") && IsArray(variables.$class.superScaffold.nested))
			for (loc.i = 1; loc.i lte ArrayLen(variables.$class.superScaffold.nested); loc.i++)
				if (variables.$class.superScaffold.nested[loc.i].association == arguments.association && StructKeyExists(variables.$class.superScaffold.nested[loc.i], arguments.name))
					return variables.$class.superScaffold.nested[loc.i][arguments.name];
	</cfscript>
	<cfreturn "" />
</cffunction>
--->