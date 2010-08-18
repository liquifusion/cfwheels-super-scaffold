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

<cffunction name="renderNestedViewActionLinks" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="key" type="numeric" required="true" />
	<cfargument name="association" type="string" required="true" />
	<cfscript>
		var loc = { returnValue = "" };
		
		loc.controller = $controller(arguments.association).$createControllerObject(variables.params);
		
		if (!Len(loc.controller.$getSetting(name="actions")));
			return loc.returnValue;
		
		loc.controllerName = loc.controller.$controllerName();
		
		loc.returnValue &= scaffoldLinkToView(controller=loc.controllerName, key=arguments.key);
		loc.returnValue &= scaffoldLinkToEdit(text="Edit", controller=loc.controllerName, key=arguments.key, class="edit");
		loc.returnValue &= scaffoldLinkToDelete(controller=loc.controllerName, key=arguments.key, class="edit");
	</cfscript>
	<cfreturn loc.returnValue />
</cffunction>

<cffunction name="renderAssociationLinks" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="key" type="numeric" required="true" />
	<cfargument name="association" type="string" required="false" default="" />
	<cfscript>
		var loc = { returnValue = "" };
		
		if (Len(arguments.association))
		{
			try
			{
				loc.controller = $controller(arguments.association).$createControllerObject(variables.params);
				return loc.controller.renderAssociationLinks(key=arguments.key);
			}
			catch (Any e)
			{
				return loc.returnValue;
			}
		}
		
		if (!StructKeyExists(variables.$class.superscaffold, "nested") || !StructKeyExists(variables.$class.superscaffold.nested, "associations"))
			return loc.returnValue;
			
		for (loc.i = 1; loc.i lte ArrayLen(variables.$class.superscaffold.nested.associations); loc.i++)
		{
			loc.association = variables.$class.superscaffold.nested.associations[loc.i];
			loc.returnValue &= scaffoldLinkTo(action="nested", key=arguments.key, association=loc.association.association, text=capitalize(humanize(loc.association.label)), title=capitalize(humanize(loc.association.label)), class="#loc.association.association# nested");
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
				loc.returnValue &= renderViewField(property=loc.property, object=arguments.object);
				loc.currentFieldSet = loc.property.fieldset;
			}
			else if (StructKeyExists(loc.property, "fieldset") && loc.property.fieldset neq loc.currentFieldSet && Len(loc.property.fieldset))
			{
				// we have a fieldset already open so close it and open a new one
				// create a new opening fieldset tag and render the form field
				loc.returnValue &= endFieldsetTag();
				loc.returnValue &= startFieldsetTag(title=loc.property.fieldset);
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
		
		if (StructKeyExists(arguments.property, "type") && arguments.property.type == "hasMany" && StructKeyExists(arguments.object, arguments.property.property) && IsArray(arguments.object[arguments.property.property]) && ArrayLen(arguments.object[arguments.property.property]))
		{
			loc.args = {
				  returnAs = "string"
				, partial = "viewlist"
				, associationName = arguments.property.property
				, properties = arguments.object[arguments.property.property][1].displayPropertiesFor("list")
				, modelName = arguments.object[arguments.property.property][1].$modelName()
				, models = arguments.object[arguments.property.property]
			};
			$loadDataForProperties(properties=loc.args.properties);
			return renderPartial(argumentCollection=loc.args);
		}
		
		loc.returnValue &= $tag(name="dl");
		loc.attributes = { class = "#arguments.property.property# label"};
		loc.returnValue &= $element(name="dt", content=arguments.object.$label(arguments.property.property), attributes=loc.attributes);
		loc.attributes = { class = "#arguments.property.property# value"};
		loc.returnValue &= $element(name="dd", content=displayProperty(argumentCollection=arguments), attributes=loc.attributes);
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
		
		arguments.name = arguments.object.$modelName();
		
		// build our object name
		if (Len(arguments.nesting) && arguments.position)
			arguments.name = arguments.nesting & "['" & pluralize(arguments.object.$modelName()) & "']" & "[" & arguments.position & "]";
		else if (Len(arguments.nesting))
			arguments.name = arguments.nesting & "['" & arguments.object.$modelName() & "']";
		loc.property = arguments.property.property;
		
		loc.overrideMethod = arguments.object.$modelName() & loc.property & "FormField";
		
		if (StructKeyExists(variables, loc.overrideMethod))
			return $invoke(method=loc.overrideMethod, argumentCollection=arguments);
		
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
				loc.returnValue &= scaffoldCheckbox(objectName=arguments.name, property=loc.property, description=loc.description);
				loc.returnValue &= errorMessageOn(objectName=arguments.name, property=loc.property);
				break;
			}
			
			case "cf_sql_tinyint": case "cf_sql_smallint": case "cf_sql_integer": case "cf_sql_bigint": case "cf_sql_real": case "cf_sql_numeric": case "cf_sql_float": case "cf_sql_decimal": case "cf_sql_double":
			{
				loc.returnValue &= scaffoldTextField(objectName=arguments.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#");
				loc.returnValue &= errorMessageOn(objectName=arguments.name, property=loc.property);
				break;
			}
			
			case "cf_sql_char": case "cf_sql_varchar":
			{
				if (loc.mask == "password")
					loc.returnValue &= scaffoldPasswordField(objectName=arguments.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType# #loc.mask#");
				else if (loc.data.size gt 10000)
					loc.returnValue &= scaffoldTextArea(objectName=arguments.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#");
				else
					loc.returnValue &= scaffoldTextField(objectName=arguments.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType# #loc.mask#");
				loc.returnValue &= errorMessageOn(objectName=arguments.name, property=loc.property);

				break;
			}
			
			case "cf_sql_date": case "cf_sql_timestamp": case "cf_sql_time":
			{
				loc.returnValue &= scaffoldTextField(objectName=arguments.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType# date", includeBlank=loc.required);
				loc.returnValue &= errorMessageOn(objectName=arguments.name, property=loc.property);
				break;
			}
			
			case "hasMany":
			{
				loc.returnValue = renderSubForm(baseObject=arguments.object, object=model(arguments.property.modelName), association=loc.property);
				break;
			}
			
			case "hasOne":
			{
				loc.keys = arguments.object[loc.property].primaryKey();
				for (loc.i = 1; loc.i lte ListLen(loc.keys); loc.i++)
					if (StructKeyExists(arguments.object[loc.property], ListGetAt(loc.keys, loc.i)))
						loc.returnValue &= hiddenField(objectName=arguments.name, property=ListGetAt(loc.keys, loc.i), association=loc.property);
				loc.returnValue &= renderFormFields(properties=arguments.object[loc.property].displayPropertiesFor(params.action), object=arguments.object[loc.property], nesting=arguments.name);
				break;
			}
			
			case "belongsTo":
			{
				loc.returnValue &= scaffoldSelect(label=loc.data.label, objectName=arguments.name, property="#arguments.property.foreignKey#", options=variables[pluralize(loc.property)], description=loc.description, class="text #loc.required#", includeBlank="Select a #capitalize(humanize(loc.property))#");
				loc.returnValue &= errorMessageOn(objectName=arguments.name, property="#arguments.property.foreignKey#");
				break;
			}
			
			case "hasOptions":
			{
				loc.returnValue &= scaffoldSelect(label=loc.data.label, objectName=arguments.name, property="#loc.property#", options=loc.options, description=loc.description, class="text #loc.required#", includeBlank="Select a #arguments.property.label#");
				loc.returnValue &= errorMessageOn(objectName=arguments.name, property="#loc.property#");
				break;
			}
			
			default:
			{
				$dump(arguments);
				loc.returnValue = scaffoldTextArea(objectName=arguments.name, property=loc.property, description=loc.description, class="text #loc.required# #loc.data.validationType#");
				loc.returnValue &= errorMessageOn(objectName=arguments.name, property=loc.property);
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
		loc.association = arguments.association;
		loc.nesting = arguments.baseObject.$modelName();
		loc.properties = arguments.object.displayPropertiesFor(arguments.action);
		$loadDataForProperties(properties=loc.properties);
		// we need an extra model on the end for our hidden row
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
	<cfargument name="property" type="struct" required="true" />
	<cfargument name="object" type="component" required="true" />
	<cfscript>
		var loc = { returnValue = "" };
		loc.modelName = arguments.object.$modelName();
		loc.displayOverrideMethod = loc.modelName & arguments.property.property & "Display";
		
		// add the value to the arguments to be able to easily get it in display overrides
		arguments.value = "";
		if (StructKeyExists(arguments.object, arguments.property.property))
			arguments.value = arguments.object[arguments.property.property];
		
		if (StructKeyExists(variables, loc.displayOverrideMethod) && (!IsSimpleValue(arguments.value) || Len(arguments.value)))
			returnValue = $invoke(method=loc.displayOverrideMethod, argumentCollection=arguments);

		else if (StructKeyExists(arguments.property, "type") && arguments.property.type eq "hasMany" && !ArrayIsEmpty(arguments.value) && StructKeyExists(arguments.value[1], "display"))
			returnValue = arguments.value[1].display;

		else if (StructKeyExists(arguments.property, "type") && ListFindNoCase("hasOne,belongsTo", arguments.property.type) && IsObject(arguments.value) && StructKeyExists(arguments.value, "display"))
			returnValue = arguments.value.display;

		else if (IsSimpleValue(arguments.value) && Len(arguments.value) && arguments.value != "false")
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

<cffunction name="scaffoldURLFor" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="controller" type="string" required="false" default="#variables.$class.name#" />
	<cfif StructKeyExists(arguments, "action") and arguments.action eq "list">
		<cfset StructDelete(arguments, "action") />
	</cfif>
	<cfreturn URLFor(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldLinkTo" access="public" output="false" returntype="string" mixin="controller">
	<cfargument name="route" type="string" required="false" default="superScaffold" />
	<cfargument name="controller" type="string" required="false" default="#variables.$class.name#" />
	<cfreturn linkTo(argumentCollection=arguments) & " " />
</cffunction>

<cffunction name="scaffoldLinkToBack" access="public" output="false" returntype="any" mixin="controller">
	<cfargument name="text" type="string" required="false" default="<span>Back</span>" />
	<cfargument name="title" type="string" required="false" default="#stripTags(arguments.text)#" />
	<cfargument name="class" type="string" required="false" default="interface-button back" />
	<cfargument name="controllerParams" type="struct" required="false" default="#variables.params#" />
	<cfscript>
		if (!ListFindNoCase($getSetting(name="actions"), "list"))
			return;
		if (ListLen(arguments.controllerParams.returnParams) gt 1 && arguments.controllerParams.action == "nested")
			return linkTo(text=arguments.text, title=arguments.title, class=arguments.class, href=ListGetAt(arguments.controllerParams.returnParams, 2));
		else if (ListLen(arguments.controllerParams.returnParams) && ListFirst(arguments.controllerParams.returnParams) != scaffoldURLFor(argumentCollection=arguments.controllerParams))
			return linkTo(text=arguments.text, title=arguments.title, class=arguments.class, href=ListFirst(arguments.controllerParams.returnParams));
		StructDelete(arguments, "controllerParams", false);
	</cfscript>
	<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldLinkToDelete" access="public" output="false" returntype="any" mixin="controller">
	<cfargument name="text" type="string" required="false" default="<span>Delete</span>" />
	<cfargument name="title" type="string" required="false" default="#stripTags(arguments.text)#" />
	<cfargument name="action" type="string" required="false" default="delete" />
	<cfargument name="class" type="string" required="false" default="interface-button delete" />
	<cfif ListFindNoCase($getSetting(name="actions"), "delete")>
		<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
	</cfif>
</cffunction>

<cffunction name="scaffoldLinkToEdit" access="public" output="false" returntype="any" mixin="controller">
	<cfargument name="text" type="string" required="false" default="<span>Edit this Object</span>" />
	<cfargument name="title" type="string" required="false" default="#stripTags(arguments.text)#" />
	<cfargument name="action" type="string" required="false" default="edit" />
	<cfargument name="class" type="string" required="false" default="interface-button edit" />
	<cfif ListFindNoCase($getSetting(name="actions"), "edit")>
		<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
	</cfif>
</cffunction>

<cffunction name="scaffoldLinkToNew" access="public" output="false" returntype="any" mixin="controller">
	<cfargument name="text" type="string" required="false" default="<span>Create a new Object</span>" />
	<cfargument name="title" type="string" required="false" default="#stripTags(arguments.text)#" />
	<cfargument name="action" type="string" required="false" default="new" />
	<cfargument name="class" type="string" required="false" default="interface-button new" />
	<cfif ListFindNoCase($getSetting(name="actions"), "new")>
		<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
	</cfif>
</cffunction>

<cffunction name="scaffoldLinkToView" access="public" output="false" returntype="any" mixin="controller">
	<cfargument name="text" type="string" required="false" default="View" />
	<cfargument name="title" type="string" required="false" default="#arguments.text#" />
	<cfargument name="action" type="string" required="false" default="view" />
	<cfargument name="class" type="string" required="false" default="view" />
	<cfif ListFindNoCase($getSetting(name="actions"), "view")>
		<cfreturn scaffoldLinkTo(argumentCollection=arguments) />
	</cfif>
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












