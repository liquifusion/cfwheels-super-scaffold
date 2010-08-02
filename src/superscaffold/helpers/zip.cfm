<cffunction name="$zip" returntype="any" access="public" output="false">
	<cfscript>
		var loc = {};
		$args(name="$zip", args=arguments, combine="directories/directory");
		
		if (StructKeyExists(arguments, "action"))
		{
			switch (arguments.action)
			{
				case "list": { arguments.name = "loc.name"; break; }
				case "deleteDirectories": { return $zipDeleteDirectories(argumentCollection=arguments); }
			}
		}
	</cfscript>
	<cfzip attributeCollection="#arguments#" />
	<cfif StructKeyExists(loc, "name")>
		<cfreturn loc.name />
	</cfif>
</cffunction>

<cffunction name="$zipDeleteDirectories" access="public" output="false" returntype="void">
	<cfargument name="file" type="string" required="true" />
	<cfargument name="directories" type="string" required="true" />
	<cfscript>
		var loc = {};
		loc.directories = $listClean(list=arguments.directories, returnAs="array");
		
		for (loc.i = 1; loc.i lte ArrayLen(loc.directories); loc.i++)
		{
			loc.found = true;
			loc.directory = loc.directories[loc.i];
		
			while (loc.found)
			{
				loc.found = false;
				loc.list = $zip(action="list", file=arguments.file, showdirectory=true);
				
				for (loc.j = 1; loc.j lte loc.list.RecordCount; loc.j++)
				{
					if (loc.list.type[loc.j] == "Directory" && ListFindNoCase(loc.list.name[loc.j], loc.directory, "/"))
					{
						loc.found = true;
						loc.entryPath = "";
						// we found the directory in the name so lets build the directory to delete
						for (loc.k = 1; loc.k lte ListFindNoCase(loc.list.name[loc.j], loc.directory, "/"); loc.k++)
							loc.entryPath = ListAppend(loc.entryPath, ListGetAt(loc.list.name[loc.j], loc.k, "/"), "/");
						$zip(action="delete", file=arguments.file, entryPath=loc.entryPath);
					}
					
					if (loc.found)
						break;
				}
			}
		}
	</cfscript>
</cffunction>