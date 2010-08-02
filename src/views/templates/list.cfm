<cfoutput>
	<div class="list">
		
		<!--- new link --->
		<div class="links">
			#scaffoldLinkTo(action="new", text="<span>Create a new #capitalize(modelName)#</span>", title="Create a new #capitalize(modelName)#", class="interface-button new")#
		</div>

		<div class="heading">
			<h1>#displayHeading()#</h1>
		</div>
		
		<!--- search bar --->
		#includePartial(partial="listsearch")#
		
		<div class="listings">
		
			<table>
				<thead>
					<tr>
						<cfloop array="#properties#" index="property">
							<th class="#property.property#<cfif params.s eq property.property or (StructKeyExists(property, "sorting") && property.sorting eq params.s)> #params.d#</cfif>">
								#propertySortLink(property=property, model=modelObject)#
							</th>
						</cfloop>
						<th class="action-links">&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<cfif ArrayLen(list)>
						#includePartial(partial="listitem", objects=list)#
					<cfelse>
						#includePartial(partial="norecords")#
					</cfif>
				</tbody>
			</table>
		
		</div>
		
		#includePartial(partial="pagination")#
	</div>
</cfoutput>