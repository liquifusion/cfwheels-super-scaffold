<cfoutput>
	<table class="sub-form">
		<thead>
			<!--- loop through properties that should be displayed and show headings --->
			<cfloop array="#loc.properties#" index="loc.property">
				<th>
					#loc.property.label#
				</th>
			</cfloop>
			<th>&nbsp;</th>
		</thead>
		<tbody>
			#includePartial(partial="subformitem", objects=loc.models, properties=loc.properties, nesting=loc.nesting, modelName=loc.modelName, association=loc.association)#
			<tr class="new-row-button">
				<td colspan="99">
				<!--
					<!--- javascript button to add a new row (the html should be rendered in comments for the new item) --->
					<button type="button" class="sub-form-add-button">
						<span>Add another #humanize(loc.modelName)#</span>
					</button>
				-->
				</td>
			</tr>
		</tbody>
	</table>
</cfoutput>