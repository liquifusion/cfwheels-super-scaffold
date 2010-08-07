<cfscript>
	// create our directories if needed
	if (!DirectoryExists(get("imageScaffoldPathExpanded")))
		$directory(action="create", directory=get("imageScaffoldPathExpanded"));
	if (!DirectoryExists(get("javascriptScaffoldPathExpanded")))
		$directory(action="create", directory=get("javascriptScaffoldPathExpanded"));
	if (!DirectoryExists(get("stylesheetScaffoldPathExpanded")))
		$directory(action="create", directory=get("stylesheetScaffoldPathExpanded"));

	// unzip our assets into the proper locations
	$zip(action="unzip", file=get("pluginImageAssetPathExpanded"), destination=get("imageScaffoldPathExpanded"), overwrite=false);
	$zip(action="unzip", file=get("pluginJavascriptAssetPathExpanded"), destination=get("javascriptScaffoldPathExpanded"), overwrite=false);
	$zip(action="unzip", file=get("pluginStylesheetsAssetPathExpanded"), destination=get("stylesheetScaffoldPathExpanded"), overwrite=false);
	
	// add our includes into config/routes.cfm and events/onapplicationstart.cfm
	$wheels = { array = [], i = 1 };
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
	
	role = model("role").create(title="Admin", description="This is the description for the admin roles that explains what anyone in the role can access.");
	model("user").create(roleId=role.id, firstName="Admin", lastName="Admin", emailAddress="admin@admin.com", authenticationToken="admin");
	
	$location(url="/admin?reload=true", addtoken=false);
</cfscript>