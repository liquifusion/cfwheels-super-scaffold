<cfoutput>
	<tr<cfif loc.current mod 2 eq 0> class="alternate-row"</cfif>>
		<cfloop array="#properties#" index="property">
			<td class="#property.property#">
				#displayProperty(object=loc[modelName], property=property)#
			</td>
		</cfloop>
		<td class="action-links">
			#renderAssociationLinks(key=loc[modelObject.primaryKey()])#
			#scaffoldLinkToView(key=loc[modelObject.primaryKey()])#
			#scaffoldLinkToEdit(key=loc[modelObject.primaryKey()], text="Edit", class="edit", name=modelName)#
			#scaffoldLinkToDelete(key=loc[modelObject.primaryKey()], text="Delete", class="delete")#
		</td>
	</tr>
</cfoutput>