<cfoutput>
	<table class="view-list">
		<thead>
			<tr>
				<cfloop array="#loc.properties#" index="loc.property">
					<th>
						#loc.property.label#
					</th>
				</cfloop>
				<th class="action-links">&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<cfif ArrayLen(loc.models)>
				#includePartial(partial="viewlistitem", objects=loc.models, properties=loc.properties, modelName=loc.modelName, associationName=loc.associationName)#
			<cfelse>
				#includePartial(partial="norecords")#
			</cfif>
		</tbody>
	</table>
	
</cfoutput>