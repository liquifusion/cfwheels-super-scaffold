<cfoutput>
	<div class="list">
		
		<!--- new link --->
		<div class="links">
			#scaffoldLinkTo(text="<span>Back to list</span>", title="Back to list", class="interface-button back")#
			#scaffoldLinkTo(
				  controller=params.association
				, action="new"
				, key=variables[modelName][modelObject.primaryKey()]
				, association=modelName
				, params=nestedReturnParams()
				, text="<span>Create a new #capitalize(humanize(associationName))#</span>"
				, title="View"
				, class="interface-button new")#
		</div>

		<div class="heading">
			<h1>#displayNestedHeading(object=variables[modelName])#</h1>
		</div>
		
		<!--- search bar --->
		#includePartial(partial="nestedsearch")#
		
		<div class="listings">
	
			<table>
				<thead>
					<tr>
						<cfloop array="#properties#" index="property">
							<th class="#property.property#<cfif params.s eq property.property> #params.d#</cfif>">
								#propertySortLink(property=property, model=associationObject, action="nested", key=params.key, association=params.association)#
							</th>
						</cfloop>
						<th class="action-links">&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<cfif ArrayLen(variables[modelName][params.association])>
						#includePartial(partial="nestedlistitem", objects=variables[modelName][params.association])#
					<cfelse>
						#includePartial(partial="norecords")#
					</cfif>
				</tbody>
			</table>
	
		</div>
		
		#includePartial(partial="pagination")#
	</div>
</cfoutput>