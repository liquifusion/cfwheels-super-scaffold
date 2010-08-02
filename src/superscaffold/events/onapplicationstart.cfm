<cfscript>
	// setup our bundle data so we can loop through them and create threads to make this go faster
	$wheels = { bundleArray = [], threadList = "", rootPath = "" };
	
	if (get("webPath") != "/")
		$wheels.rootPath  = ListAppend($wheels.rootPath, get("webPath"), "/");
	
	set(routesScaffoldPath = ListAppend($wheels.rootPath, get("configPath"), "/") & "/routes.cfm");
	set(onApplicationStartScaffoldPath = ListAppend($wheels.rootPath, get("eventPath"), "/") & "/onapplicationstart.cfm");
	set(imageScaffoldPath = ListAppend($wheels.rootPath, get("imagePath"), "/") & "/scaffold");
	set(pluginScaffoldAssetPath = ListAppend($wheels.rootPath, get("pluginPath"), "/") & "/superscaffold/assets");
	set(javascriptScaffoldPath = ListAppend($wheels.rootPath, get("javascriptPath"), "/") & "/scaffold");
	set(stylesheetScaffoldPath = ListAppend($wheels.rootPath, get("stylesheetPath"), "/") & "/scaffold");
	
	set(routesScaffoldPathExpanded = ExpandPath(get("routesScaffoldPath")));
	set(onApplicationStartScaffoldPathExpanded = ExpandPath(get("onApplicationStartScaffoldPath")));
	set(imageScaffoldPathExpanded = ExpandPath(get("imageScaffoldPath")));
	set(javascriptScaffoldPathExpanded = ExpandPath(get("javascriptScaffoldPath")));
	set(stylesheetScaffoldPathExpanded = ExpandPath(get("stylesheetScaffoldPath")));

	set(pluginImageAssetPathExpanded = ExpandPath(get("pluginScaffoldAssetPath") & "/images/scaffold.zip"));
	set(pluginJavascriptAssetPathExpanded = ExpandPath(get("pluginScaffoldAssetPath") & "/javascripts/scaffold.zip"));
	set(pluginStylesheetsAssetPathExpanded = ExpandPath(get("pluginScaffoldAssetPath") & "/stylesheets/scaffold.zip"));
	
	// let's have two controller paths so we can have some default controllers for the super scaffold plugin
	set(controllerPath="controllers,plugins/superscaffold/controllers");
	
	// css bundles
	$wheels.bundleArray[1] = {
		  type="css"
		, bundle="scaffold/bundles/core"
		, compress=true
		, sources="
			  scaffold/blueprint/screen
			, scaffold/blueprint/plugins/fancy-type/screen
			, scaffold/base
			, scaffold/body
			, scaffold/buttons
			, scaffold/footer
			, scaffold/forms
			, scaffold/header
			, scaffold/headings
			, scaffold/lists
			, scaffold/navigation
			, scaffold/view"
	};
	
	$wheels.bundleArray[2] = {
		  type="css"
		, bundle="scaffold/bundles/ie"
		, compress=true
		, sources="scaffold/blueprint/ie"
	};
	
	$wheels.bundleArray[3] = {
		  type="css"
		, bundle="scaffold/bundles/print"
		, compress=true
		, sources="scaffold/blueprint/print"
	};
	
</cfscript>

<!--- loop through our array so we can create all of the bundles at once --->
<cfloop index="$wheels.i" from="1" to="#ArrayLen($wheels.bundleArray)#">
	<cfset $wheels.threadList = ListAppend($wheels.threadList, Right(CreateUUID(), 8)) />
	<cfthread action="run" name="#ListLast($wheels.threadList)#" bundle="#$wheels.bundleArray[$wheels.i]#">
		<cfset generateBundle(argumentCollection=attributes.bundle) />
	</cfthread>
</cfloop>

<cfthread action="join" name="#$wheels.threadList#" timeout="10000" />

<cfset StructDelete(variables, "$wheels") />

