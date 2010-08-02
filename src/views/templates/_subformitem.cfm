<cfoutput>
	<tr>
		<cfloop array="#loc.properties#" index="loc.property">
			<td>#renderFormField(property=loc.property, object=loc[loc.modelName], nesting=loc.nesting, position=loc.current)#</td>
		</cfloop>
		<td><!--- need hidden field for delete and remove button for javascript in comments so we can easily pull it out ---></td>
	</tr>
</cfoutput>