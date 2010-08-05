<cfcomponent output="false" dependency="assetbundler,flashhelpers,provides,sessioncache,singletimeselect">
	<cfinclude template="superscaffold/superscaffold.cfm" />
	<cfinclude template="superscaffold/actions/functions.cfm" />
	<cfinclude template="superscaffold/config/functions.cfm" />
	<cfinclude template="superscaffold/controller/functions.cfm" />
	<cfinclude template="superscaffold/global/functions.cfm" />
	<cfinclude template="superscaffold/helpers/functions.cfm" />
	<cfinclude template="superscaffold/model/functions.cfm" />
	<cfinclude template="superscaffold/view/functions.cfm" />
	
	<cffunction name="init" access="public" output="false">
		<cfset $setGlobalDefaults() />
		<cfset this.version = "1.1" />
		<cfreturn this />
	</cffunction>	
	
</cfcomponent>