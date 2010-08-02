<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			scaffoldAdmin(
				  controllers=[ [ "settings", "states" ], [ "users", "roles", "permissions" ] ]
			);
		</cfscript>
	</cffunction>
	
</cfcomponent>