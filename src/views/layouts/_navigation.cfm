<cfoutput>
	<ul class="clearfix">
		<li class="dashboard">
			#scaffoldNavigationLinkTo(
				  controller = ""
				, class = "dashboard"
				, text = "Dashboard")#
		</li>
		<cfloop from="1" to="#ArrayLen(application.wheels.scaffoldNavigation)#" index="i">
			<cfif IsSimpleValue(application.wheels.scaffoldNavigation[i])>
				<li class="#application.wheels.scaffoldNavigation[i]#">
					#scaffoldNavigationLinkTo(
						  controller = application.wheels.scaffoldNavigation[i]
						, class = application.wheels.scaffoldNavigation[i]
						, text = capitalize(humanize(application.wheels.scaffoldNavigation[i])))#
				</li>
			<cfelseif IsArray(application.wheels.scaffoldNavigation[i])>
				<li class="#application.wheels.scaffoldNavigation[i][1]#">
					#scaffoldNavigationLinkTo(
						  controller = application.wheels.scaffoldNavigation[i][1]
						, class = application.wheels.scaffoldNavigation[i][1]
						, text = capitalize(humanize(application.wheels.scaffoldNavigation[i][1]))
						, matchTo = ArrayToList(application.wheels.scaffoldNavigation[i]))#
					<ul>
						<cfloop from="2" to="#ArrayLen(application.wheels.scaffoldNavigation[i])#" index="j">
							<li class="#application.wheels.scaffoldNavigation[i][j]#">
								#scaffoldNavigationLinkTo(
									  controller = application.wheels.scaffoldNavigation[i][j]
									, class = application.wheels.scaffoldNavigation[i][j]
									, text = capitalize(humanize(application.wheels.scaffoldNavigation[i][j])))#
							</li>
						</cfloop>
					</ul>
				</li>
			</cfif>
		</cfloop>
	</ul>
</cfoutput>