<cfoutput>
	<ul class="clearfix">
		<li class="dashboard">
			#scaffoldNavigationLinkTo(
				  controller = ""
				, class = "dashboard"
				, text = "Dashboard")#
		</li>
		<cfloop from="1" to="#ArrayLen(application.superscaffold.controllers)#" index="i">
			<cfif IsSimpleValue(application.superscaffold.controllers[i])>
				<li class="#application.superscaffold.controllers[i]#">
					#scaffoldNavigationLinkTo(
						  controller = application.superscaffold.controllers[i]
						, class = application.superscaffold.controllers[i]
						, text = capitalize(humanize(application.superscaffold.controllers[i])))#
				</li>
			<cfelseif IsArray(application.superscaffold.controllers[i])>
				<li class="#application.superscaffold.controllers[i][1]#">
					#scaffoldNavigationLinkTo(
						  controller = application.superscaffold.controllers[i][1]
						, class = application.superscaffold.controllers[i][1]
						, text = capitalize(humanize(application.superscaffold.controllers[i][1]))
						, matchTo = ArrayToList(application.superscaffold.controllers[i]))#
					<ul>
						<cfloop from="2" to="#ArrayLen(application.superscaffold.controllers[i])#" index="j">
							<li class="#application.superscaffold.controllers[i][j]#">
								#scaffoldNavigationLinkTo(
									  controller = application.superscaffold.controllers[i][j]
									, class = application.superscaffold.controllers[i][j]
									, text = capitalize(humanize(application.superscaffold.controllers[i][j])))#
							</li>
						</cfloop>
					</ul>
				</li>
			</cfif>
		</cfloop>
	</ul>
</cfoutput>