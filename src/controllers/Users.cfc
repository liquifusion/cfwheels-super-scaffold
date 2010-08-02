<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			scaffold(modelName="user");
			scaffoldList(sorting="lastName", paginationPerPage=10);
			scaffoldNested(association="addresses", label="Addresses");
		</cfscript>
	</cffunction>
	
</cfcomponent>