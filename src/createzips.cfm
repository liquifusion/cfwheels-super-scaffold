<cfscript>
	$wheels = {};
	$wheels.array = [
		  { source = get("imageScaffoldPathExpanded"), pluginDirectory = get("pluginImageAssetPathExpanded") }
		, { source = get("javascriptScaffoldPathExpanded"), pluginDirectory = get("pluginJavascriptAssetPathExpanded") }
		, { source = get("stylesheetScaffoldPathExpanded"), pluginDirectory = get("pluginStylesheetsAssetPathExpanded") }
	];
	
	for ($wheels.i = 1; $wheels.i lte ArrayLen($wheels.array); $wheels.i++)
	{
		$wheels.item = $wheels.array[$wheels.i];
		$wheels.file = GetTempDirectory() & "zip.zip";
		
		// first get our source and zip it up into the temp directory
		$zip(action="zip", file=$wheels.file, source=$wheels.item.source, overwrite=true);
		// delete any directories out of the zip that we don't want
		$zip(action="deleteDirectories", file=$wheels.file, directories=".svn,_notes,bundles");
		// unzip the files into our plugin directory so we can put them into revision control
		$zip(action="unzip", file=$wheels.file, destination=$wheels.item.pluginDirectory, overwrite=true);
		// clean up after ourselves
		$file(action="delete", file=$wheels.file);
	}
	
	flashInsert(success="The assets were zipped up successfully.");
</cfscript>