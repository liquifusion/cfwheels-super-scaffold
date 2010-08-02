<cffunction name="$scaffoldDescription" returntype="void" access="public" output="false" mixin="controller">
	<cfargument name="args" type="struct" required="true" />
	<cfscript>
		var attributes = { class = "description" };
		if (StructKeyExists(arguments.args, "description") && Len(arguments.args.description))
			arguments.args.append = $element(name = "span", content=arguments.args.description, attributes=attributes);
		StructDelete(arguments.args, "description", false);
	</cfscript>
</cffunction>

<cffunction name="scaffoldTextField" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldTextField", reserved="type,name,value", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn textField(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldPasswordField" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldPasswordField", reserved="type,name,value", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn passwordField(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldHiddenField" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldHiddenField", reserved="type,name,value", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn hiddenField(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldFileField" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldFileField", reserved="type,name", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn fileField(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldTextArea" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldTextArea", reserved="name", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn textArea(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldRadioButton" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldRadioButton", reserved="type,name,value,checked", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn radioButton(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldCheckBox" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldCheckBox", reserved="type,name,value,checked", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn checkBox(argumentCollection=arguments) />
</cffunction>

<cffunction name="scaffoldSelect" returntype="string" access="public" output="false" mixin="controller">
	<cfset $args(name="scaffoldSelect", reserved="name", args=arguments) />
	<cfset $scaffoldDescription(args=arguments) />
	<cfreturn select(argumentCollection=arguments) />
</cffunction>


