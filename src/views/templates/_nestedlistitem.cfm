<cfoutput>
	<tr<cfif loc.current mod 2 eq 0> class="alternate-row"</cfif>>
		<cfloop array="#properties#" index="property">
			<td class="#property.property#">
				#displayProperty(modelName=associationName, property=property, value=loc[property.property])#
			</td>
		</cfloop>
		<td class="action-links">
			#scaffoldLinkTo(controller=params.association, action="view", params=nestedReturnParams(), key=loc[modelObject.primaryKey()], text="View", title="View", class="view")#
			#scaffoldLinkTo(controller=params.association, action="edit", params=nestedReturnParams(), key=loc[modelObject.primaryKey()], text="Edit", title="Edit", class="edit")#
			#scaffoldLinkTo(controller=params.association, action="delete", params=nestedReturnParams(), key=loc[modelObject.primaryKey()], text="Delete", title="Delete", class="delete")#
		</td>
	</tr>
</cfoutput>