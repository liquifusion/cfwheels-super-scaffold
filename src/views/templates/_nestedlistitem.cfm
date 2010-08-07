<cfoutput>
	<tr<cfif loc.current mod 2 eq 0> class="alternate-row"</cfif>>
		<cfloop array="#properties#" index="property">
			<td class="#property.property#">
				#displayProperty(object=loc[associationName], property=property)#
			</td>
		</cfloop>
		<td class="action-links">
			#renderAssociationLinks(key=loc[modelObject.primaryKey()], association=params.association)#
			#scaffoldLinkToView(controller=params.association, key=loc[modelObject.primaryKey()])#
			#scaffoldLinkToEdit(text="Edit", class="delete", controller=params.association, key=loc[modelObject.primaryKey()])#
			#scaffoldLinkToDelete(text="Delete", class="delete", controller=params.association, key=loc[modelObject.primaryKey()])#
		</td>
	</tr>
</cfoutput>