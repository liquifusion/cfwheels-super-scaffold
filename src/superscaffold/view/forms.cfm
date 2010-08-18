<cffunction name="$formValue" returntype="string" access="public" output="false">
	<cfargument name="objectName" type="any" required="true">
	<cfargument name="property" type="string" required="true">
	<cfargument name="applyHtmlEditFormat" type="boolean" required="false" default="true" />
	<cfscript>
		var originalFormValue = core.$formValue;
		var loc = {};
		
		if (!IsStruct(arguments.objectName))
		{
			loc.object = $getObject(arguments.objectName);
			loc.modelName = loc.object.$modelName();
			loc.helperMethod = loc.modelName & arguments.property & "FormValue";
			if (StructKeyExists(variables, loc.helperMethod) && StructKeyExists(loc.object, arguments.property))
			{
				return $invoke(method=loc.helperMethod, object=loc.object, property=arguments.property, value=loc.object[arguments.property]);
			}
		}
	</cfscript>
	<cfreturn originalFormValue(argumentCollection=arguments) />
</cffunction>