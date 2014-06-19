<cfscript>
	generateBundle(
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
			, scaffold/view");
	
	generateBundle(
		  type="css"
		, bundle="scaffold/bundles/ie"
		, compress=true
		, sources="
			  scaffold/blueprint/ie
			, scaffold/ie");
	
	generateBundle(
		  type="css"
		, bundle="scaffold/bundles/print"
		, compress=true
		, sources="scaffold/blueprint/print");
	
	generateBundle(
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
			, scaffold/implementation/notices");
</cfscript>

