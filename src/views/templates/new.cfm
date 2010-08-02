<cfoutput>
	<div class="new">
		
		<!--- back link --->
		<div class="links">
			#scaffoldLinkToBack()#
		</div>
	
		<div class="heading">
			<h1>#displayHeading()#</h1>
		</div>
		
		<div class="form">
			#scaffoldStartFormTag(action="create")#
			
				<cfif StructKeyExists(params, "return")>
					#hiddenFieldTag(name="return", value=HTMLEditFormat(stripTags(params.return)))#
				</cfif>
				
				<cfif StructKeyExists(params, "association") && StructKeyExists(params, "key")>
					#hiddenField(objectName=modelName, property=modelObject.$foreignKeyForAssociation(associationName))#
				</cfif>
			
				#renderFormFields(properties=properties, object=variables[modelName])#
				
				<p class="controls">#buttonTag(content="<span>Create</span>", type="submit", class="interface-button save")# <span>or #scaffoldLinkToBack(text="cancel", title="cancel", class="cancel")#</span></p>
			
			#endFormTag()#
		</div>
		
	</div>
</cfoutput>