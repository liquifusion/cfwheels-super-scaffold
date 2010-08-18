<cfoutput>
	<div class="heading">
		<h1>Application</h1>
	</div>
	
	<div class="form">
		<p>You can change the applications environment by choosing it below and clicking submit.</p>
		#scaffoldStartFormTag(action="save")#
			
			<cfloop from="1" to="#arrayLen(environments)#" index="i">
				#radioButtonTag(name="environment", value="#environments[i]#", label="#capitalize(environments[i])#", checked=IIF(get('environment') is environments[i], true, false))#
			</cfloop>
				
			<p class="controls">
				#buttonTag(content="<span>Update</span>", type="submit", class="interface-button save")#
			</p>
		#endFormTag()#
	</div>
</cfoutput>