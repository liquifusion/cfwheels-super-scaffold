<cfscript>
	// setup our bundle data so we can loop through them and create threads to make this go faster
	$wheels = { bundleArray = [], threadList = "" };
	
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
			, scaffold/dashboard
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
		
	// js bundle
	$wheels.bundleArray[4] = {
		  type="js"
		, bundle="scaffold/bundles/core"
		, compress=true
		, sources="
			  scaffold/lib/jquery-1.4.2
			, scaffold/lib/jquery.address-1.2.2
			, scaffold/lib/jquery.comments
			, scaffold/lib/jquery.livequery
			, scaffold/lib/jquery.metadata
			, scaffold/lib/jquery.scrollTo-1.4.2
			, scaffold/lib/jquery.showpassword
			, scaffold/lib/jquery.superfish
			, scaffold/lib/jquery.url
			, scaffold/implementation/global
			, scaffold/implementation/list
			, scaffold/implementation/form
			, scaffold/implementation/navigation
			, scaffold/implementation/notices"
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

