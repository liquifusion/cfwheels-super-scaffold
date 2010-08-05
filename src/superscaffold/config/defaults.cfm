<cffunction name="$setGlobalDefaults" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		var loc = { rootPath = "" };
		// set our application defaults that are needed for the entire admin area
		application.wheels.scaffoldNavigation = [ [ "users", "roles" ] ];
		application.wheels.scaffoldTitle = "Site Administration";
		application.wheels.scaffoldDeveloper = "Liquifusion Studios";
		application.wheels.scaffoldDeveloperLink = "http://www.liquifusion.com";
		application.wheels.scaffoldCopyrightStartYear = Year(Now());
	
		// defaults for our init() method calls --->
		application.wheels.functions.scaffold = { actions = "create,update,delete,view,nested", formats = "html,xml,json,csv,xls" };
		application.wheels.functions.scaffoldList = { paginationEnabled = true, paginationWindowSize = 3, paginationPerPage = 20, sorting = "primaryKeys", sortingDirection = "asc" };
		application.wheels.functions.scaffoldView = { returnToAction = "list" };
		application.wheels.functions.scaffoldSearch = { textSearch = "full" };
		application.wheels.functions.scaffoldCreate = { returnToAction = "list", multipart = false };
		application.wheels.functions.scaffoldUpdate = { returnToAction = "list", multipart = false };
		application.wheels.functions.scaffoldDelete = { returnToAction = "list" };
		
		// set defaults for all of our form functions --->
		application.wheels.functions.scaffoldTextField = { prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div" };
		application.wheels.functions.scaffoldPasswordField = { prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div" };
		application.wheels.functions.scaffoldFileField = { prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div" };
		application.wheels.functions.scaffoldTextArea = { prependToLabel="<p>", append="</p>", labelPlacement="before", cols="5000" };
		application.wheels.functions.scaffoldRadioButton = { prependToLabel="<p class=""checkbox"">", append="</p>", labelPlacement="after", errorElement="div" };
		application.wheels.functions.scaffoldCheckBox = { prepend="<p class=""checkbox"">", appendToLabel="</p>", labelPlacement="after", errorElement="div" };
		application.wheels.functions.scaffoldSelect = { prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div" };
		application.wheels.functions.scaffoldDateSelect = {prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div" };
		application.wheels.functions.scaffoldTimeSelect = { prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div" };
		application.wheels.functions.scaffoldSingleTimeSelect = { prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div", minuteStep=15 };
		application.wheels.functions.scaffoldDateTimeSelect = { prependToLabel="<p>", append="</p>", labelPlacement="before", errorElement="div" };
		
		if (application.wheels.webPath != "/")
			loc.rootPath  = ListAppend(loc.rootPath, application.wheels.webPath, "/");
		
		application.wheels.appScaffoldPath = ListAppend(loc.rootPath, application.wheels.configPath, "/") & "/app.cfm";
		application.wheels.routesScaffoldPath = ListAppend(loc.rootPath, application.wheels.configPath, "/") & "/routes.cfm";
		application.wheels.onApplicationStartScaffoldPath = ListAppend(loc.rootPath, application.wheels.eventPath, "/") & "/onapplicationstart.cfm";
		application.wheels.imageScaffoldPath = ListAppend(loc.rootPath, application.wheels.imagePath, "/") & "/scaffold";
		application.wheels.pluginScaffoldAssetPath = ListAppend(loc.rootPath, application.wheels.pluginPath, "/") & "/superscaffold";
		application.wheels.javascriptScaffoldPath = ListAppend(loc.rootPath, application.wheels.javascriptPath, "/") & "/scaffold";
		application.wheels.stylesheetScaffoldPath = ListAppend(loc.rootPath, application.wheels.stylesheetPath, "/") & "/scaffold";
		
		application.wheels.appScaffoldPathExpanded = ExpandPath(application.wheels.appScaffoldPath);
		application.wheels.routesScaffoldPathExpanded = ExpandPath(application.wheels.routesScaffoldPath);
		application.wheels.onApplicationStartScaffoldPathExpanded = ExpandPath(application.wheels.onApplicationStartScaffoldPath);
		application.wheels.imageScaffoldPathExpanded = ExpandPath(application.wheels.imageScaffoldPath);
		application.wheels.javascriptScaffoldPathExpanded = ExpandPath(application.wheels.javascriptScaffoldPath);
		application.wheels.stylesheetScaffoldPathExpanded = ExpandPath(application.wheels.stylesheetScaffoldPath);
	
		application.wheels.pluginImageAssetPathExpanded = ExpandPath(application.wheels.pluginScaffoldAssetPath & "/images/scaffold.zip");
		application.wheels.pluginJavascriptAssetPathExpanded = ExpandPath(application.wheels.pluginScaffoldAssetPath & "/javascripts/scaffold.zip");
		application.wheels.pluginStylesheetsAssetPathExpanded = ExpandPath(application.wheels.pluginScaffoldAssetPath & "/stylesheets/scaffold.zip");
		
		// let's have two controller paths so we can have some default controllers for the super scaffold plugin
		application.wheels.controllerPath="controllers,plugins/superscaffold/controllers";
		application.wheels.modelPath="models,plugins/superscaffold/models";
	</cfscript>
</cffunction>

