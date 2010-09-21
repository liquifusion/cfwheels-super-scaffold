<cffunction name="property" access="public" output="false" returntype="void" mixin="model">
	<cfargument name="name" type="string" required="true" />
	<cfargument name="column" type="string" required="false" default="" />
	<cfargument name="sql" type="string" required="false" default="" />
	<cfargument name="label" type="string" required="false" default="" />
	<cfargument name="defaultValue" type="string" required="false" />
	<cfargument name="mask" type="string" required="false" hint="Possible values include password, phone, date" />
	<cfargument name="description" type="string" required="false" hint="Adds a description to the form field." />
	<cfargument name="displayOn" type="string" required="false" default="list,view,new,edit,delete" hint="Adds a description to the form field." />
	<cfargument name="sorting" type="string" required="false" />
	<cfargument name="order" type="numeric" required="false" hint="overrides the order the property displayed" />
	<cfscript>
		var item = "";
		var originalProperty = core.property;
		
		if (!StructKeyExists(variables.wheels.class, "mappingcounter"))
			variables.wheels.class.mappingcounter = 0;
		variables.wheels.class.mappingcounter++;

		// create the key
		if (!StructKeyExists(variables.wheels.class.mapping, arguments.name))
			variables.wheels.class.mapping[arguments.name] = {};
		
		// setup the display on property
		if (arguments.displayOn == "all")
			arguments.displayOn = "list,search,view,new,edit,delete";
		if (ListFindNoCase(arguments.displayOn, "new"))
			arguments.displayOn = ListAppend(arguments.displayOn, "create");
		if (ListFindNoCase(arguments.displayOn, "edit"))
			arguments.displayOn = ListAppend(arguments.displayOn, "update");
		variables.wheels.class.mapping[arguments.name].displayOn = arguments.displayOn;	
		
		// set the order for the mappings
		variables.wheels.class.mapping[arguments.name].order = variables.wheels.class.mappingcounter;	
		
		for (item in arguments)
			if (!ListFindNoCase("name,column,sql,label,defaultValue,displayOn", item) && StructKeyExists(arguments, item))
				variables.wheels.class.mapping[arguments.name][item] = arguments[item];
	</cfscript>
	<cfreturn originalProperty(argumentCollection=arguments) />
</cffunction>

<cffunction name="$modelName" access="public" output="false" returntype="string" mixin="model">
	<cfreturn variables.wheels.class.modelName>
</cffunction>

<cffunction name="$label" access="public" output="false" returntype="string" mixin="model">
	<cfargument name="property" type="string" required="true">
	<cfscript>
		returnValue = "";
		if (StructKeyExists(variables.wheels.class.mapping, arguments.property) && StructKeyExists(variables.wheels.class.mapping[arguments.property], "label"))
			returnValue = variables.wheels.class.mapping[arguments.property].label;
		else if (StructKeyExists(variables.wheels.class.associations, arguments.property) && StructKeyExists(variables.wheels.class.associations[arguments.property], "label"))
			returnValue = variables.wheels.class.associations[arguments.property].label;
	</cfscript>
	<cfreturn returnValue />
</cffunction>

<cffunction name="mappingDataForProperty" access="public" output="false" returntype="any" mixin="model">
	<cfargument name="property" type="string" required="true" />
	<cfscript>
		var mappingData = false;
		if (StructKeyExists(variables.wheels.class.mapping, arguments.property))
			mappingData = variables.wheels.class.mapping[arguments.property];
	</cfscript>
	<cfreturn mappingData />
</cffunction>

<cffunction name="searchProperties" access="public" output="false" returntype="string" mixin="model">
	<cfscript>
		var loc = { list = "" };
		
		// build the list of properties to display for the area passed in
		for (loc.item in variables.wheels.class.mapping)
			if (ListFindNoCase(variables.wheels.class.mapping[loc.item].displayOn, "search"))
				loc.list = ListAppend(loc.list, loc.item);
	</cfscript>
	<cfreturn loc.list />
</cffunction>

<cffunction name="displayPropertiesFor" access="public" output="false" returntype="array" mixin="model">
	<cfargument name="area" type="string" required="true" />
	<cfscript>
		var loc = { list = [] };

		// build the list of properties to display for the area passed in
		for (loc.item in variables.wheels.class.mapping)
		{
			if (ListFindNoCase(variables.wheels.class.mapping[loc.item].displayOn, arguments.area))
			{
				loc.list = $propertiesForArea(arguments.area, loc.item, variables.wheels.class.mapping[loc.item], loc.list);
			}
		}

		// also add in any associations that have displayOn
		loc.keyList = StructKeyList(variables.wheels.class.associations);
		for (loc.i = 1; loc.i lte ListLen(loc.keyList); loc.i++)
		{
			loc.item = ListGetAt(loc.keyList, loc.i);
			if (StructKeyExists(variables.wheels.class.associations[loc.item], "displayOn") && ListFindNoCase(variables.wheels.class.associations[loc.item].displayOn, arguments.area))
			{
				loc.a = $expandedAssociations(loc.item);
				loc.list = $propertiesForArea(arguments.area, loc.item, loc.a[1], loc.list);
			}
		}
		loc.list = $reorderPropertiesForArea(arguments.area, loc.list);
	</cfscript>
	<cfreturn loc.list />
</cffunction>

<cffunction name="$propertiesForArea" access="public" returntype="array" output="false">
	<cfargument name="area" type="string" required="true">
	<cfargument name="name" type="string" required="true">
	<cfargument name="data" type="struct" required="true">
	<cfargument name="container" type="array" required="true">
	<cfscript>
	var loc = {};

	arguments.data.property = arguments.name;

	loc.position = $propertyOrderForArea(arguments.area, arguments.data);

	if (loc.position gt ArrayLen(arguments.container))
	{
		ArrayResize(arguments.container, loc.position);
	}

	if (ArrayIsDefined(arguments.container, loc.position))
	{
		ArrayInsertAt(arguments.container, loc.position, arguments.data);
	}
	else
	{
		arguments.container[loc.position] = arguments.data;
	}
	</cfscript>
	<cfreturn arguments.container>
</cffunction>

<cffunction name="$propertyOrderForArea" access="public" returntype="numeric" output="false">
	<cfargument name="area" type="string" required="true">
	<cfargument name="data" type="struct" required="true">
	<cfscript>
	// if order exists for the area, return that instead
	if (StructKeyExists(arguments.data, "order#arguments.area#"))
	{
		return arguments.data["order#arguments.area#"];
	}
	</cfscript>
	<cfreturn arguments.data.order>
</cffunction>

<cffunction name="$reorderPropertiesForArea" access="public" returntype="array" output="false">
	<cfargument name="area" type="string" required="true">
	<cfargument name="container" type="array" required="true">
	<cfscript>
	var loc = {};

	loc.iEnd = ArrayLen(arguments.container);
	for (loc.i = loc.iEnd; loc.i gte 1; loc.i--)
	{
		if (!ArrayIsDefined(arguments.container, loc.i))
		{
			ArrayDeleteAt(arguments.container, loc.i);
		}
	}

	loc.iEnd = ArrayLen(arguments.container);
	for (loc.i = 1; loc.i lte loc.iEnd; loc.i++)
	{
		arguments.container[loc.i].order = loc.i;
		arguments.container[loc.i]["order#arguments.area#"] = loc.i;
	}
	</cfscript>
	<cfreturn arguments.container>
</cffunction>
