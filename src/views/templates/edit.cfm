<cfoutput>
	<div class="new">
	
		<div class="links">
			#scaffoldLinkToBack()#
			#scaffoldLinkToDelete(key=variables[modelName][modelObject.primaryKey()])#
		</div>
	
		<div class="heading">
			<h1>#displayHeading()#</h1>
		</div>
		
		<div class="form">
			#scaffoldStartFormTag(action="update")#
			
				<cfif StructKeyExists(params, "return")>
					#hiddenFieldTag(name="return", value=HTMLEditFormat(stripTags(params.return)))#
				</cfif>
			
				<cfloop list="#modelObject.primaryKey()#" index="property">
					#renderHiddenFormField(property=property, object=variables[modelName])#
				</cfloop>
			
				#renderFormFields(properties=properties, object=variables[modelName])#
				
				<p class="controls">
					#buttonTag(content="<span>Update</span>", type="submit", class="interface-button save")#
					<cfif ListFindNoCase($getSetting(name="actions"), "list")>
						<span>or #scaffoldLinkToBack(text="cancel", title="cancel", class="cancel")#</span>
					</cfif>
				</p>
			
			#endFormTag()#
		</div>
		
	</div>
</cfoutput>