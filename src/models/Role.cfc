<cfcomponent extends="Model" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			property(name="display", sql="(roles.title)", label="Role Name", displayOn="");
			property(name="title", label="Title", displayOn="all", fieldset="Role Info");
			property(name="description", label="Description", displayOn="all");
			hasMany(name="users");
		</cfscript>
	</cffunction>

</cfcomponent>