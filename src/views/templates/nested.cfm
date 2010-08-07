<cfoutput>
	<div class="list">
		
		<!--- new link --->
		<div class="links">
			#scaffoldLinkToBack()#
			#scaffoldLinkToNew(text="<span>Create a new #humanize(associationName)#</span>", controller=params.association, key=variables[modelName][modelObject.primaryKey()], association=modelName)#
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