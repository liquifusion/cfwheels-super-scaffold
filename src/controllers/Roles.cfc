<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			scaffold(modelName="role");
			scaffoldList(sorting="title", paginationPerPage=10);
		</cfscript>
	</cffunction>
	
</cfcomponent>