<cfscript>
	// zip up our images
	$zip(action="zip", file=get("pluginImageAssetPathExpanded"), source=get("imageScaffoldPathExpanded"), overwrite=true);
	$zip(action="deleteDirectories", file=get("pluginImageAssetPathExpanded"), directories=".svn,_notes");
	
	// zip up our javascripts
	$zip(action="zip", file=get("pluginJavascriptAssetPathExpanded"), source=get("javascriptScaffoldPathExpanded"), overwrite=true);
	$zip(action="deleteDirectories", file=get("pluginJavascriptAssetPathExpanded"), directories=".svn");
	
	// zip up our stylesheets
	$zip(action="zip", file=get("pluginStylesheetsAssetPathExpanded"), source=get("stylesheetScaffoldPathExpanded"), overwrite=true);
	$zip(action="deleteDirectories", file=get("pluginStylesheetsAssetPathExpanded"), directories=".svn,bundles");
	
	flashInsert(success="The assets were zipped up successfully.");
</cfscript>