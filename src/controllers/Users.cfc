<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			scaffold(modelName="user", actions="create,update,delete,view,nested,changePassword,savepassword");
			scaffoldList(sorting="lastName", paginationPerPage=10);
		</cfscript>
	</cffunction>
	
	<cffunction name="changePassword" access="public" output="false" returntype="void">
		<cfscript>
			user = sessionCache("user");
			user.authenticationToken = "";
		</cfscript>
	</cffunction>
	
	<cffunction name="savePassword" access="public" output="false" returntype="void">
		<cfscript>
			user = sessionCache("user");
			user.authenticationToken = params.user.authenticationToken;
			user.save();
			flashInsert(success="Your password has been successfully changed.");
			scaffoldRedirectTo(action="change-password");
		</cfscript>
	</cffunction>
	
</cfcomponent>