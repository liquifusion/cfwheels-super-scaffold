<cfoutput>
	<tr<cfif loc.current mod 2 eq 0> class="alternate-row"</cfif>>
		<cfloop array="#properties#" index="property">
			<td class="#property.property#">
				<cftry>
				#displayProperty(modelName=modelName, property=property, value=loc[property.property])#
				<cfcatch type="any">
					#$dump(property)#
				</cfcatch>
				</cftry>
			</td>
		</cfloop>
		<td class="action-links">
			#renderAssocicationLinks(key=loc[modelObject.primaryKey()])#
			#scaffoldLinkTo(action="view", key=loc[modelObject.primaryKey()], text="View", title="View", class="view")#
			#scaffoldLinkTo(action="edit", key=loc[modelObject.primaryKey()], text="Edit", title="Edit", class="edit")#
			#scaffoldLinkTo(action="delete", key=loc[modelObject.primaryKey()], text="Delete", title="Delete", class="delete")#
		</td>
	</tr>
</cfoutput>