<cffunction name="startFieldsetTag" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="title" type="string" required="true" />
	<cfset var returnValue = $tag(name="div", attributes ={ class="fieldset" }) />
	<cfset returnValue &= $tag(name="fieldset") />
	<cfset returnValue &= $element(name="legend", content=$element(name="span", content=arguments.title)) />
	<cfreturn returnValue />
</cffunction>

<cffunction name="endFieldsetTag" access="public" output="false" returntype="string" mixin="controller">
	<cfreturn "</fieldset></div>" />
</cffunction>

<cffunction name="renderAssocicationLinks" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="key" type="numeric" required="true" />
	<cfscript>
		var loc = { returnValue = "" };
		
		if (!StructKeyExists(variables.$class.superscaffold, "nested"))
			return loc.returnValue;
			
		for (loc.i = 1; loc.i lte ArrayLen(variables.$class.superscaffold.nested); loc.i++)
		{
			loc.association = variables.$class.superscaffold.nested[loc.i];
			
			loc.returnValue &= scaffoldLinkTo(action="nested", key=arguments.key, association=loc.association.association, text=capitalize(humanize(loc.association.label)), title=capitalize(humanize(loc.association.label)));
			loc.returnValue &= " ";
		}
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="renderViewFields" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="properties" type="array" required="true" />
	<cfargument name="object" type="component" required="true" />
	<cfscript>
		var loc = { currentFieldSet = "", returnValue = "" };
		
		for (loc.i = 1; loc.i lte ArrayLen(arguments.properties); loc.i++)
		{
			loc.property = arguments.properties[loc.i];
			
			if (StructKeyExists(loc.property, "fieldset") && loc.property.fieldset neq loc.currentFieldSet && loc.currentFieldSet == "")
			{
				// create a new opening fieldset tag and render the form field
				loc.returnValue &= startFieldsetTag(title=loc.property.fieldset);
				
				// insert our property
				loc.returnValue &= renderViewField(property=loc.property, object=arguments.object);
				loc.currentFieldSet = loc.property.fieldset;
			}
			else if (StructKeyExists(loc.property, "fieldset") && loc.property.fieldset neq loc.currentFieldSet && Len(loc.property.fieldset))
			{
				// we have a fieldset already open so close it and open a new one
				// create a new opening fieldset tag and render the form field
				loc.returnValue &= endFieldsetTag();
				loc.returnValue &= startFieldsetTag(title=loc.property.fieldset);
				
				// insert our property
				loc.returnValue &= renderViewField(property=loc.property, object=arguments.object);
				loc.currentFieldSet = loc.property.fieldset;
			}
			else if (StructKeyExists(loc.property, "fieldset") && loc.property.fieldset neq loc.currentFieldSet && !Len(loc.property.fieldset))
			{
				// we have a fieldset already open so close it and open a new one
				// create a new opening fieldset tag and render the form field
				loc.returnValue &= endFieldsetTag();
				loc.returnValue &= renderViewField(property=loc.property, object=arguments.object);
				loc.currentFieldSet = loc.property.fieldset;
			}
			else
			{
				loc.returnValue &= renderViewField(property=loc.property, object=arguments.object);
			}
		}
		
		if (Len(loc.currentFieldSet))
			loc.returnValue &= endFieldsetTag();
		
		// clean up our generated html code and remove any dl's that open and close
		// next to each other
		loc.returnValue = Replace(loc.returnValue, "</dl><dl>", "", "all");
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="renderViewField" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="property" type="struct" required="true" />
	<cfargument name="object" type="component" required="true" />
	<cfscript>
		var loc = { returnValue = "" };
		loc.returnValue &= $tag(name="dl");
		loc.attributes = { class = "#arguments.property.property# label"};
		loc.returnValue &= $element(name="dt", content=arguments.object.$label(arguments.property.property), attributes=loc.attributes);
		loc.attributes = { class = "#arguments.property.property# value"};
		loc.returnValue &= $element(name="dd", content=displayProperty(modelName=arguments.object.$modelName(), property=arguments.property, value=arguments.object[arguments.property.property]), attributes=loc.attributes);
		loc.returnValue &= "</dl>";
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="renderFormFields" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="properties" type="array" required="true" />
	<cfargument name="object" type="component" required="true" />
	<cfargument name="nesting" type="string" required="false" default="" />
	<cfscript>
		var loc = { currentFieldSet = "", returnValue = "" };
		
		for (loc.i = 1; loc.i lte ArrayLen(arguments.properties); loc.i++)
		{
			loc.property = arguments.properties[loc.i];
			
			if (StructKeyExists(loc.property, "fieldset") && loc.property.fieldset neq loc.currentFieldSet && loc.currentFieldSet == "")
			{
				// create a new opening fieldset tag and render the form field
				loc.returnValue &= startFieldsetTag(title=loc.property.fieldset);
				loc.returnValue &= renderFormField(property=loc.property, object=arguments.object, nesting=arguments.nesting);
				loc.currentFieldSet = loc.property.fieldset;
			}
			else if (StructKeyExists(loc.property, "fieldset") && loc.property.fieldset neq loc.currentFieldSet && Len(loc.property.fieldset))
			{
				// we have a fieldset already open so close it and open a new one
				// create a new opening fieldset tag and render the form field
				loc.returnValue &= endFieldsetTag();
				loc.returnValue &= startFieldsetTag(title=loc.property.fieldset);
				loc.returnValue &= renderFormField(property=loc.property, object=arguments.object, nesting=arguments.nesting);
				loc.currentFieldSet = loc.property.fieldset;
			}
			else if (StructKeyExists(loc.property, "fieldset") && loc.property.fieldset neq loc.currentFieldSet && !Len(loc.property.fieldset))
			{
				// we have a fieldset already open so close it and open a new one
				// create a new opening fieldset tag and render the form field
				loc.returnValue &= endFieldsetTag();
				loc.returnValue &= renderFormField(property=loc.property, object=arguments.object, nesting=arguments.nesting);
				loc.currentFieldSet = loc.property.fieldset;
			}
			else
			{
				loc.returnValue &= renderFormField(property=loc.property, object=arguments.object, nesting=arguments.nesting);
			}
		}
		
		if (Len(loc.currentFieldSet))
			loc.returnValue &= endFieldsetTag();
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="renderFormField" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="property" type="struct" required="true" />
	<cfargument name="object" type="component" required="true" />
	<cfargument name="nesting" type="string" required="false" default="" />
	<cfargument name="position" type="numeric" required="false" default="0" />
	<cfscript>
		var loc = {};
		loc.name = arguments.object.$modelName();
		
		// build our object name
		if (Len(arguments.nesting) && arguments.position)
			loc.name = arguments.nesting & "['" & pluralize(arguments.object.$modelName()) & "']" & "[" & arguments.position & "]";
		else if (Len(arguments.nesting))
			loc.name = arguments.nesting & "['" & arguments.object.$modelName() & "']";
		loc.property = arguments.property.property;
		
		if (StructKeyExists(variables, "#loc.name##loc.property#formField"))
			return Evaluate("#loc.name##loc.property#display(property=arguments.property, value=arguments.value)");		
		
		loc.returnValue = "";
		
		if (StructKeyExists(arguments.property, "type"))
			loc.data = arguments.property;
		else
			loc.data = arguments.object.columnDataForProperty(loc.property);

		loc.mask = "";
		if (StructKeyExists(arguments.property, "mask"))
			loc.mask = arguments.property.mask;

		loc.required = "";
		if (StructKeyExists(loc.data, "nullable") && !loc.data.nullable)
			loc.required = "required";

			
		loc.description = "";
		if (StructKeyExists(arguments.property, "description"))
			loc.description = arguments.property.description;
			
		loc.options = "";
		if (StructKeyExists(arguments.property, "options"))
		{
			loc.options = arguments.property.options;
			loc.data.type = "hasOptions";
		}
		
		switch(loc.data.type)
		{
			case "cf_sql_bit":
			{
				loc.returnValue &= scaffoldCheckbox(objectName=loc.name, property=loc.property, description=loc.description);
				loc.returnValue &= errorMessageOn(objectName=loc.name, property=loc.property);
				break;
			}
			
			case "cf_sql_tinyint": case "cf_sql_smallint": case "cf_sql_integer": case "cf_sql_bigint": case "cf_sql_real": case "cf_sql_numeric": case "cf_sql_float": case "cf_sql_decimal": case "cf_sql_double":
			{
				loc.returnValue &= scaffoldTextField(objectName=loc.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#");
				loc.returnValue &= errorMessageOn(objectName=loc.name, property=loc.property);
				break;
			}
			
			case "cf_sql_char": case "cf_sql_varchar":
			{
				try
				{
					if (loc.mask == "password")
						loc.returnValue &= scaffoldPasswordField(objectName=loc.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType# #loc.mask#");
					else
						loc.returnValue &= scaffoldTextField(objectName=loc.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType# #loc.mask#");
					loc.returnValue &= errorMessageOn(objectName=loc.name, property=loc.property);
				}
				catch (Any e)
				{
					$dump(loc);
				}
				break;
			}
						
			case "cf_sql_time":
			{
				loc.returnValue &= scaffoldSingleTimeSelect(objectName=loc.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#", includeBlank=loc.required);
				loc.returnValue &= errorMessageOn(objectName=loc.name, property=loc.property);
				break;
			}
			
			case "cf_sql_date":
			{
				loc.returnValue &= scaffoldDateSelect(objectName=loc.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#", includeBlank=loc.required);
				loc.returnValue &= errorMessageOn(objectName=loc.name, property=loc.property);
				break;
			}
			
			case "cf_sql_timestamp":
			{
				loc.returnValue &= scaffoldDateTimeSelect(objectName=loc.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#", includeBlank=loc.required);
				loc.returnValue &= errorMessageOn(objectName=loc.name, property=loc.property);
				break;
			}
			
			case "hasMany":
			{
				loc.returnValue = renderSubForm(baseObject=arguments.object, object=model(arguments.property.modelName), association=loc.property);
				break;
			}
			
			case "hasOne":
			{
				loc.returnValue &= renderFormFields(properties=arguments.object[loc.property].displayPropertiesFor(params.action), object=arguments.object[loc.property], nesting=loc.name);
				break;
			}
			
			case "belongsTo":
			{
				loc.returnValue &= scaffoldSelect(label=loc.data.label, objectName=loc.name, property="#arguments.property.foreignKey#", options=variables[pluralize(loc.property)], description=loc.description, class="text #loc.required#", includeBlank="Select a #capitalize(humanize(loc.property))#");
				loc.returnValue &= errorMessageOn(objectName=loc.name, property="#arguments.property.foreignKey#");
				break;
			}
			
			case "hasOptions":
			{
				loc.returnValue &= scaffoldSelect(label=loc.data.label, objectName=loc.name, property="#loc.property#", options=loc.options, description=loc.description, class="text #loc.required#", includeBlank="Select a #arguments.property.label#");
				loc.returnValue &= errorMessageOn(objectName=loc.name, property="#loc.property#");
				break;
			}
			
			default:
			{
				$dump(arguments);
				loc.returnValue = scaffoldTextArea(objectName=loc.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#");
				loc.returnValue &= errorMessageOn(objectName=loc.name, property=loc.property);
				break;
			}
		}
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="renderSubForm" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="object" type="component" required="true" />
	<cfargument name="baseObject" type="component" required="true" />
	<cfargument name="association" type="string" required="true" />
	<cfargument name="action" type="string" required="false" default="#params.action#" />
	<cfscript>
		var loc = {};
		loc.modelName = arguments.object.$modelName();
		loc.nesting = arguments.baseObject.$modelName();
		loc.properties = arguments.object.displayPropertiesFor(arguments.action);
		$loadDataForProperties(properties=loc.properties);
		if (ArrayIsEmpty(arguments.baseObject[arguments.association]))
			ArrayAppend(arguments.baseObject[arguments.association], model(arguments.object.$modelName()).new());
		loc.models = arguments.baseObject[arguments.association];
	</cfscript>
	<cfreturn renderPartial(partial="subform", returnAs="string", argumentCollection=loc) />
</cffunction>

<cffunction name="renderHiddenFormField" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="property" type="string" required="true" />
	<cfargument name="object" type="component" required="true" />
	<cfscript>
		var loc = {};
		loc.name = object.$modelName();
		loc.returnValue = scaffoldHiddenField(objectName=loc.name, property=arguments.property);
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="propertySortLink" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="property" type="struct" required="true" />
	<cfargument name="model" type="component" required="true" />
	<cfscript>
		var sortColumn = arguments.property.property;
		
		if (StructKeyExists(arguments.property, "sorting"))
			sortColumn = arguments.property.sorting;
			
		arguments.text = arguments.model.$label(arguments.property.property);
		arguments.title = "Sort by #arguments.property.label#";
		arguments.params = buildSortingParams(column=sortColumn, model=arguments.model);
		
		StructDelete(arguments, "property");
		StructDelete(arguments, "model");
	</cfscript>
	<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
</cffunction>

<cffunction name="buildSortingParams" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="model" type="component" required="true" />
	<cfargument name="column" type="string" required="true" />
	<cfscript>
		var returnValue = "p=1&amp;s=#arguments.column#&amp;search=#params.search#&amp;";
		if (params.s == arguments.column && params.d == "asc")
			returnValue &= "d=desc";
		else
			returnValue &= "d=asc";
	</cfscript>
	<cfreturn returnValue />
</cffunction>

<cffunction name="displayProperty" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="modelName" type="string" required="true" />
	<cfargument name="property" type="struct" required="true" />
	<cfargument name="value" type="any" required="true" />
	<cfscript>
		var returnValue = "";
		if (StructKeyExists(variables, "#arguments.modelName##arguments.property.property#display"))
			returnValue = Evaluate("#arguments.modelName##arguments.property.property#display(property=arguments.property.property, value=arguments.value)");
		else if (StructKeyExists(arguments.property, "type") && arguments.property.type eq "hasMany" && !ArrayIsEmpty(arguments.value) && StructKeyExists(arguments.value[1], "display"))
			returnValue = arguments.value[1].display;
		else if (StructKeyExists(arguments.property, "type") && ListFindNoCase("hasOne,belongsTo", arguments.property.type) && IsObject(arguments.value) && StructKeyExists(arguments.value, "display"))
			returnValue = arguments.value.display;
		else if (IsSimpleValue(arguments.value) && Len(arguments.value))
			returnValue = arguments.value;
		else
			returnValue = "-";
	</cfscript>
	<cfreturn returnValue />
</cffunction>

<cffunction name="displayNestedHeading" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="object" type="component" required="true" />
	<cfargument name="action" type="string" required="false" default="#variables.params.action#" />
	<cfargument name="association" type="string" required="false" default="#variables.params.association#" />
	<cfscript>
		var heading = capitalize(humanize(arguments.association)) & " for " & arguments.object.display;
	</cfscript>
	<cfreturn heading />
</cffunction>

<cffunction name="displayHeading" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="action" type="string" required="false" default="#variables.params.action#" />
	<cfscript>
		var loc = {
			action = (arguments.action == "index") ? "list" : arguments.action
		};
		loc.heading = $getSetting(name="label", sectionName=arguments.action, searchRoot=false);
		
		if (!Len(loc.heading))
		{
			if (loc.action == "list")
				loc.heading = singularize($getSetting(name="label")) & " " & capitalize(loc.action);
			else
				loc.heading = capitalize(loc.action) & " " & singularize($getSetting(name="label"));
		}
	</cfscript>
	<cfreturn loc.heading />
</cffunction>

<cffunction name="buildPagiationParams" access="public" output="false" returntype="string" mixin="controller">
	<cfreturn "search=#params.search#&amp;s=#params.s#&amp;d=#params.d#" />
</cffunction>

<cffunction name="scaffoldStartFormTag" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="controller" type="string" required="false" default="#variables.params.controller#" />
	<cfif StructKeyExists(arguments, "action") && IsBoolean($getSetting(name="multipart", sectionName=arguments.action))>
		<cfset arguments.multipart = $getSetting(name="multipart", sectionName=arguments.action) />
	</cfif>
	<cfreturn startFormTag(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldLinkTo" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="controller" type="string" required="false" default="#variables.params.controller#" />
	<cfscript>
		var loc = { returnValue = "", list = $getSetting(name="actions") };
		if (!StructKeyExists(arguments, "action") || ListFindNoCase(loc.list, arguments.action))
			loc.returnValue = linkTo(argumentCollection=arguments);
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="scaffoldLinkToBack" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="text" type="string" required="false" default="<span>Back to list</span>" />
	<cfargument name="title" type="string" required="false" default="#stripTags(arguments.text)#" />
	<cfargument name="class" type="string" required="false" default="interface-button back" />
	<cfargument name="params" type="struct" required="false" default="#variables.params#" />
	<cfscript>
		if (StructKeyExists(arguments.params, "return"))
			arguments.href = arguments.params.return;
			
		StructDelete(arguments, "params");
	</cfscript>
	<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldLinkToDelete" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="text" type="string" required="false" default="<span>Delete</span>" />
	<cfargument name="title" type="string" required="false" default="#stripTags(arguments.text)#" />
	<cfargument name="action" type="string" required="false" default="delete" />
	<cfargument name="class" type="string" required="false" default="interface-button delete" />
	<cfargument name="params" type="struct" required="false" default="#variables.params#" />
	<cfscript>
		if (StructKeyExists(arguments.params, "return"))
			arguments.params = nestedReturnParams();
		else
			StructDelete(arguments, "params");
	</cfscript>
	<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldLinkToEdit" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="text" type="string" required="false" default="<span>Edit this #capitalize(humanize(modelName))#</span>" />
	<cfargument name="title" type="string" required="false" default="#stripTags(arguments.text)#" />
	<cfargument name="action" type="string" required="false" default="edit" />
	<cfargument name="class" type="string" required="false" default="interface-button edit" />
	<cfargument name="params" type="struct" required="false" default="#variables.params#" />
	<cfscript>
		if (StructKeyExists(arguments.params, "return"))
			arguments.params = nestedReturnParams();
		else
			StructDelete(arguments, "params");
	</cfscript>
	<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
</cffunction>


<cffunction name="nestedReturnParams" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="params" type="struct" required="false" default="#variables.params#" />
	<cfif StructKeyExists(arguments.params, "return")>
		<cfreturn "return=#arguments.params.return#" />
	</cfif>
	<cfreturn "return=#URLFor(argumentCollection=params)#" />
</cffunction>

<cffunction name="scaffoldNavigationLinkTo" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="controller" type="string" required="true" />
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="class" type="string" required="false" default="" />
	<cfargument name="text" type="string" required="false" default="" />
	<cfargument name="title" type="string" required="false" default="#arguments.text#" />
	<cfargument name="matchTo" type="string" required="false" default="" />
	<cfscript>
		if (variables.params.controller == arguments.controller || ListFindNoCase(arguments.matchTo, variables.params.controller) || (arguments.controller == "" && variables.params.controller == "admin"))
			arguments.class &= " active";
		StructDelete(arguments, "matchTo");
	</cfscript>
	<cfreturn linkTo(argumentCollection=arguments) />
</cffunction>