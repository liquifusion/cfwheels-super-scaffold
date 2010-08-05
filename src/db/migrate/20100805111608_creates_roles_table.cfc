<cfcomponent extends="plugins.dbmigrate.Migration" hint="creates roles table">
	
	<cffunction name="up">
		<cfscript>
			t = createTable("roles");
			t.string(columnNames="title", limit=50, null=false);
			t.text(columnNames="description", null=true);
			t.timestamp(columnNames="createdat,updatedat", null=false);
			t.create();
		</cfscript>
	</cffunction>
	
	<cffunction name="down">
		<cfscript>
			dropTable('roles');
		</cfscript>
	</cffunction>

</cfcomponent>
