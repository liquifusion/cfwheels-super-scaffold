<cfoutput>
	<div class="view">
		
		<!--- navigation links --->
		<div class="links">
			#scaffoldLinkToBack()#
			#scaffoldLinkToEdit(key=variables[modelName][modelObject.primaryKey()])#
			#scaffoldLinkToDelete(key=variables[modelName][modelObject.primaryKey()])#
		</div>
	
		<div class="heading">
			<h1>#displayHeading()#</h1>
		</div>
		
		<div class="properties">
			#renderViewFields(properties=properties, object=variables[modelName])#
		</div>
		
	</div>
</cfoutput>