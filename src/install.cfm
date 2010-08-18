<cfscript>
	$wheels = { array = [], i = 1 };
	$wheels.assets = [
		  { directory = get("imageScaffoldPathExpanded"), source = get("pluginImageAssetPathExpanded") }
		, { directory = get("javascriptScaffoldPathExpanded"), source = get("pluginJavascriptAssetPathExpanded") }
		, { directory = get("stylesheetScaffoldPathExpanded"), source = get("pluginStylesheetsAssetPathExpanded") }
	];
	
	for ($wheels.i = 1; $wheels.i lte ArrayLen($wheels.assets); $wheels.i++)
	{
		$wheels.item = $wheels.assets[$wheels.i];
		$wheels.file = GetTempDirectory() & "zip.zip";
		
		// make sure we have our directory
		if (!DirectoryExists($wheels.item.directory))
			$directory(action="create", directory=$wheels.item.directory);
		
		// first get our source and zip it up into the temp directory
		$zip(action="zip", file=$wheels.file, source=$wheels.item.source, overwrite=true);
		// unzip the files into our plugin directory so we can put them into revision control
		$zip(action="unzip", file=$wheels.file, destination=$wheels.item.directory, overwrite=false);
		// clean up after ourselves
		$file(action="delete", file=$wheels.file);
	}
	
	// add our includes into config/routes.cfm and events/onapplicationstart.cfm
	$wheels.array[1] = { includeString = '[cfinclude template="#get("pluginPath")#/superscaffold/config/app.cfm" /]', file = get("appScaffoldPathExpanded") };
	$wheels.array[2] = { includeString = '[cfinclude template="../#get("pluginPath")#/superscaffold/config/routes.cfm" /]', file = get("routesScaffoldPathExpanded") };
	$wheels.array[3] = { includeString = '[cfinclude template="../#get("pluginPath")#/superscaffold/events/onapplicationstart.cfm" /]', file = get("onApplicationStartScaffoldPathExpanded") };
	
	for ($wheels.i = 1; $wheels.i lte ArrayLen($wheels.array); $wheels.i++)
	{
		$wheels.item = $wheels.array[$wheels.i];
		// change our include string
		$wheels.item.includeString = ReplaceList($wheels.item.includeString, "[,]", "<,>");
		// read our file to see if the include string is there
		$wheels.item.fileContents = $file(action="read", file=$wheels.item.file);
		
		// if not, put it in with a return character
		if (!FindNoCase($wheels.item.includeString, $wheels.item.fileContents))
		{
			$wheels.item.fileContents = $wheels.item.includeString & Chr(13) & Chr(10) & $wheels.item.fileContents;
			$file(action="write", file=$wheels.item.file, output=$wheels.item.fileContents, addNewLine=false, mode=775);
		}
	}
	
	// setup our initial data
	model("role").deleteAll();
	model("user").deleteAll();
	role = model("role").create(title="Admin", description="This is the description for the admin roles that explains what anyone in the role can access.");
	model("user").create(roleId=role.id, firstName="Admin", lastName="Admin", emailAddress="admin@admin.com", authenticationToken="admin");
	
	$location(url="/admin/sessions/new?reload=true&firstinstall=$kc7g0b!", addtoken=false);
</cfscript>