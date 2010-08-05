<cfcomponent extends="plugins.dbmigrate.Migration" hint="creates roles table">
	
	<cffunction name="up">
		<cfscript>
			t = createTable("users");
			t.integer(columnNames="roleid", null=false);
			t.string(columnNames="firstname,lastname,emailaddress,authenticationtoken", limit=100, null=false);
			t.timestamp(columnNames="createdat,updatedat", null=false);
			t.create();
		</cfscript>
	</cffunction>
	
	<cffunction name="down">
		<cfscript>
			dropTable("users");
		</cfscript>
	</cffunction>

</cfcomponent>