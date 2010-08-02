<cffunction name="belongsTo" returntype="void" access="public" output="false" mixin="model">
	<cfscript>
		var originalBelongsTo = core.belongsTo;
		arguments = $setupScaffoldAssociation(argumentCollection=arguments);
	</cfscript>
	<cfreturn originalBelongsTo(argumentCollection=arguments) />
</cffunction>

<cffunction name="hasMany" returntype="void" access="public" output="false" mixin="model">
	<cfscript>
		var originalHasMany = core.hasMany;
		arguments = $setupScaffoldAssociation(argumentCollection=arguments);
	</cfscript>
	<cfreturn originalHasMany(argumentCollection=arguments) />
</cffunction>

<cffunction name="hasOne" returntype="void" access="public" output="false" mixin="model">
	<cfscript>
		var originalHasOne = core.hasOne;
		arguments = $setupScaffoldAssociation(argumentCollection=arguments);
	</cfscript>
	<cfreturn originalHasOne(argumentCollection=arguments) />
</cffunction>

<cffunction name="$foreignKeyForAssociation" access="public" output="false" returntype="string" mixin="model">
	<cfargument name="association" type="string" required="true" />
	<cfset var expandedAssociation = $expandedAssociations(arguments.association)[1] />
	<cfreturn expandedAssociation.foreignKey />
</cffunction>

<cffunction name="$setupScaffoldAssociation" access="public" output="false" returntype="struct" mixin="model">
	<cfargument name="displayOn" type="string" required="false" default="" hint="Adds a description to the form field." />
	<cfscript>
		if (!StructKeyExists(variables.wheels.class, "mappingcounter"))
			variables.wheels.class.mappingcounter = 0;
		variables.wheels.class.mappingcounter++;
		arguments.order = variables.wheels.class.mappingcounter;

		// setup the display on property
		if (arguments.displayOn == "all")
			arguments.displayOn = "list,search,view,new,edit,delete";
		if (ListFindNoCase(arguments.displayOn, "new"))
			arguments.displayOn = ListAppend(arguments.displayOn, "create");
		if (ListFindNoCase(arguments.displayOn, "edit"))
			arguments.displayOn = ListAppend(arguments.displayOn, "update");	
	</cfscript>
	<cfreturn arguments />
</cffunction>



