<cfoutput>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>#application.wheels.scaffoldTitle#</title>
	<link rel="shortcut icon" type="image/x-icon" href="/images/scaffold/favicon.png" />
	#styleSheetLinkTag(bundle="scaffold/bundles/core")#
	<!--[if lt IE 8]>
	#styleSheetLinkTag(bundle="scaffold/bundles/ie")#
	<![endif]-->	
	#styleSheetLinkTag(bundle="scaffold/bundles/print", media="print")#	
	#javaScriptIncludeTag(bundle="scaffold/bundles/core")#
</cfoutput>