<cffunction name="scaffoldNew" returntype="any" access="public" output="false" mixin="model">
	<cfscript>
		var loc = {};
		loc.object = new();
		for (loc.item in variables.wheels.class.associations)
		{
			if (variables.wheels.class.associations[loc.item].type == "hasMany")
				loc.object[loc.item] = [];
			else
				loc.object[loc.item] = model(variables.wheels.class.associations[loc.item].modelName).new();
		}
	</cfscript>
	<cfreturn loc.object />
</cffunction>

<cffunction name="scaffoldFindByKey" returntype="any" access="public" output="false" mixin="model">
	<cfset arguments.include = $associationList(displayFor="view,new,edit,delete") />
	<cfreturn findByKey(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldFindAll" returntype="any" access="public" output="false" mixin="model">
	<cfset arguments.include = $associationList(displayFor="list,nested") />
	<cfreturn findAll(argumentCollection=arguments) />
</cffunction>

<cffunction name="$associationList" access="public" output="false" returntype="string" mixin="model">
	<cfargument name="displayFor" type="string" required="true" />
	<cfscript>
		var loc = { returnValue = "" };
		for (loc.item in variables.wheels.class.associations)
			if (StructKeyExists(variables.wheels.class.associations[loc.item], "displayOn"))
				for (loc.i = 1; loc.i lte ListLen(arguments.displayFor); loc.i++)
					if (ListFindNoCase(variables.wheels.class.associations[loc.item].displayOn, ListGetAt(arguments.displayFor, loc.i)))
						loc.returnValue = ListAppend(loc.returnValue, loc.item);
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>