<cffunction name="scaffoldNew" returntype="any" access="public" output="false" mixin="model">
	<cfscript>
		var loc = {};
		loc.object = new(argumentCollection=arguments);
		for (loc.item in variables.wheels.class.associations)
		{
			if (!StructKeyExists(loc.object, loc.item))
			{
				if (variables.wheels.class.associations[loc.item].type == "hasMany")
					loc.object[loc.item] = [ model(variables.wheels.class.associations[loc.item].modelName).new() ];
				else if (variables.wheels.class.associations[loc.item].type == "hasOne")
					loc.object[loc.item] = model(variables.wheels.class.associations[loc.item].modelName).new();
			}
		}
	</cfscript>
	<cfreturn loc.object />
</cffunction>

<cffunction name="scaffoldFindByKey" returntype="any" access="public" output="false" mixin="model">
	<cfargument name="addNewAssociationObjects" type="boolean" required="false" default="true" />
	<cfscript>
		var loc = { associations = $associationList(displayFor="view,new,edit,delete") };
		loc.object = findByKey(argumentCollection=arguments);
		
		for (loc.i = 1; loc.i lte ListLen(loc.associations); loc.i++)
		{
			loc.associationName = ListGetAt(loc.associations, loc.i);
			loc.association = variables.wheels.class.associations[loc.associationName];
			loc.associationModel = model(loc.association.modelName);
			
			// set our arguments
			loc.args = {
				  include = loc.associationModel.$associationList(displayFor="view,new,edit,delete")
				, returnAs = "objects"
			};
			
			if (StructKeyExists(loc.association, "sortOrder") && Len(loc.association.sortOrder))
				loc.args.order = loc.association.sortOrder;
			
			// for some reason calling $invoke will NOT work with the loc.object reference, 
			// calling onMissingMethod directly does though, weird
			
			if (StructKeyExists(loc.association, "method") && StructKeyExists(loc.object, loc.association.method))
				loc.data = $invoke(componentReference=loc.object, method=loc.association.method);
			else
				loc.data = loc.object.onMissingMethod(loc.associationName, loc.args);
			
			if (loc.association.type == "hasMany" && (!IsArray(loc.data) || ArrayIsEmpty(loc.data)) && arguments.addNewAssociationObjects)
				loc.object[loc.associationName] = [ model(loc.association.modelName).new() ];
			else if (loc.association.type == "hasOne" && !IsObject(loc.data) && arguments.addNewAssociationObjects)
				loc.object[loc.associationName] = model(loc.association.modelName).new();
			else
				loc.object[loc.associationName] = loc.data;
		}
	</cfscript>
	<cfreturn loc.object />
</cffunction>

<cffunction name="scaffoldFindAll" returntype="any" access="public" output="false" mixin="model">
	<cfset arguments.include = $associationList(displayFor="list") />
	<cfreturn findAll(argumentCollection=arguments) />
</cffunction>

<cffunction name="$associationList" access="public" output="false" returntype="string" mixin="model">
	<cfargument name="displayFor" type="string" required="true" />
	<cfscript>
		var loc = { returnValue = "" };
		for (loc.item in variables.wheels.class.associations)
			if (StructKeyExists(variables.wheels.class.associations[loc.item], "displayOn"))
				for (loc.i = 1; loc.i lte ListLen(arguments.displayFor); loc.i++)
					if (ListFindNoCase(variables.wheels.class.associations[loc.item].displayOn, ListGetAt(arguments.displayFor, loc.i)) && !ListFindNoCase(loc.returnValue, loc.item))
						loc.returnValue = ListAppend(loc.returnValue, loc.item);
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>


