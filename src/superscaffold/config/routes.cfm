<cfscript>
	// routes
	addRoute(name="superScaffold", pattern="admin/[controller]/[action]/[key]/[association].[format]");
	addRoute(name="superScaffold", pattern="admin/[controller]/[action]/[key].[format]");
	addRoute(name="superScaffold", pattern="admin/[controller]/[action].[format]");
	addRoute(name="superScaffold", pattern="admin/[controller].[format]", action="list");
	addRoute(name="superScaffold", pattern="admin", controller="Admin", action="index");
</cfscript>