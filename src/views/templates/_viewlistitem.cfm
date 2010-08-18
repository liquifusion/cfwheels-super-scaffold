<cfoutput>
	<tr<cfif loc.current mod 2 eq 0> class="alternate-row"</cfif>>
		<cfloop array="#loc.properties#" index="loc.property">
			<td class="#loc.property.property#">
				#displayProperty(object=loc[modelName], property=loc.property)#
			</td>
		</cfloop>
		<td class="action-links">
			#renderNestedViewActionLinks(association=loc.associationName, key=loc[model(loc.modelName).primaryKey()])#
		</td>
	</tr>
</cfoutput>