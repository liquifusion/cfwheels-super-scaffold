<cffunction name="onMissingMethod" access="public" output="false" returntype="void" mixin="controller">
	<cfargument name="missingMethodName" type="string" required="true" />
	<cfargument name="missingMethodArguments" type="struct" required="true" />
	<cfscript>
		var methodToCall = "do" & params.action;
		if (StructKeyExists(variables.$class, "superscaffold"))
		{
			// see if the method exists on this controller
			if (StructKeyExists(this, methodToCall) && IsCustomFunction(this[methodToCall]))
				$invoke(componentReference=this, method=methodToCall);
			else
				$invoke(componentReference=this, method="doPageNotFound");
		}
	</cfscript>
</cffunction>