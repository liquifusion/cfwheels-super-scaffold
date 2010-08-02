<cffunction name="$setSettings" access="public" output="false" returntype="void" mixin="controller">
	<cfargument name="methodName" type="string" required="false" />
	<cfargument name="sectionName" type="string" required="false" />
	<cfscript>
		var loc = {};
		if (StructKeyExists(arguments, "methodName"))
			$args(args=arguments, name=arguments.methodName);
		
		if (!StructKeyExists(variables.$class, "superscaffold"))
			$throw(type="Wheels.Plugins.SuperScaffold.IncorrectMethodSequence", message="Please call `scaffold()` before calling `#arguments.methodName#()`.");
		
		if (StructKeyExists(arguments, "sectionName") && !StructKeyExists(variables.$class.superScaffold, arguments.sectionName))
			variables.$class.superScaffold[arguments.sectionName] = {};
			
		if (StructKeyExists(arguments, "sectionName") && StructKeyExists(arguments, "association") && !StructKeyExists(variables.$class.superScaffold[arguments.sectionName], arguments.assocation))
			variables.$class.superScaffold[arguments.sectionName][arguments.assocation] = {};
		
		if (StructKeyExists(arguments, "sectionName") && StructKeyExists(variables.$class.superScaffold, arguments.sectionName))
			loc.reference = variables.$class.superScaffold[arguments.sectionName];
		else
			loc.reference = variables.$class.superScaffold;
		
		// clean all of our lists and add them to the class data
		for (loc.item in arguments)
			if (StructKeyExists(arguments, loc.item) && !ListFindNoCase("methodName,sectionName", loc.item))
				loc.reference[loc.item] = $listClean(arguments[loc.item]);		
	</cfscript>
</cffunction>