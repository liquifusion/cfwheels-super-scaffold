<cfoutput>
	<div class="delete">
		
		<!--- navigation links --->
		<div class="links">
			#scaffoldLinkToBack()#
		</div>
	
		<div class="heading">
			<h1>#displayHeading()#</h1>
		</div>
		
		<p class="large">Are you sure you want to <strong class="strong-notice">permanently delete</strong> this #capitalize(humanize(modelName))# and all associated information?</p>
		
		<div class="properties">
			#renderViewFields(properties=properties, object=variables[modelName])#
		</div>
		
		#scaffoldStartFormTag(action="destroy", multipart=false)#
			
			<cfif StructKeyExists(params, "return")>
				#hiddenFieldTag(name="return", value=HTMLEditFormat(stripTags(params.return)))#
			</cfif>
			
			#hiddenFieldTag(name="key", value=variables[modelName][modelObject.primaryKey()])#
			
			<p class="controls" style="padding-left:0;">
				#buttonTag(content="<span>Permanently Delete</span>", type="submit", class="interface-button delete")# 
				<span>or #scaffoldLinkToBack(text="cancel", title="cancel", class="cancel")#</span>
			</p>
		#endFormTag()#
	</div>
</cfoutput>