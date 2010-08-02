<cffunction name="$setGlobalDefaults" access="public" output="false" returntype="void" mixin="controller">
	<cfscript>
		// defaults --->
		application.wheels.functions.scaffold = { actions = "create,update,delete,view,nested", formats = "html,xml,json,csv,xls" };
		application.wheels.functions.scaffoldList = { paginationEnabled = true, paginationWindowSize = 3, paginationPerPage = 20, sorting = "primaryKeys", sortingDirection = "asc" };
		application.wheels.functions.scaffoldView = { returnToAction = "list" };
		application.wheels.functions.scaffoldAdmin = { title = "Site Administration", developer = "Liquifusion Studios", developerLink = "http://www.liquifusion.com", copyrightStartYear = Year(Now()) };
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
	</cfscript>
</cffunction>