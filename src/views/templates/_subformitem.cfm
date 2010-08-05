<cfparam name="loc.id" default="" />
<cfoutput>
		<tr<cfif loc.current eq loc.totalCount> class="new-row"</cfif>>
			<cfif loc.current eq loc.totalCount><!--<table><tr></cfif>
			<cfloop array="#loc.properties#" index="loc.property">
				<td>#renderFormField(property=loc.property, object=loc[loc.modelName], nesting=loc.nesting, position=loc.current)#</td>
			</cfloop>
			<td class="delete">
				#hiddenFieldTag(name="#loc.nesting#[#loc.association#][#loc[loc.modelName].key($returnTickCountWhenNew=true)#][_delete]", value=IIf(IsNumeric(loc.id), "0", "1"))#
				<!--- 
					need hidden field for delete and remove button for javascript in comments so we can easily pull it out 
					the delete is set to true (1) until something is typed in one of the fields so we can easily discard records untouched in
					the subform
				--->
				<cfif loc.current neq loc.totalCount> 
				<!--<a href="##" title="Remove #humanize(loc.modelName)#" class="sub-form-delete-button">delete</a>-->
				<cfelse>
					<a href="##" title="Remove #humanize(loc.modelName)#" class="sub-form-delete-button">delete</a>
				</cfif>
			</td>
			<cfif loc.current eq loc.totalCount></tr></table>--></cfif>
		</tr>
</cfoutput>