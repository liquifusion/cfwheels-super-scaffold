<cfoutput>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>#application.superscaffold.title#</title>
	#styleSheetLinkTag(bundle="scaffold/bundles/core")#
	<!--[if lt IE 8]>
	#styleSheetLinkTag(bundle="scaffold/bundles/ie")#
	<![endif]-->	
	#styleSheetLinkTag(bundle="scaffold/bundles/print", media="print")#	
</cfoutput>