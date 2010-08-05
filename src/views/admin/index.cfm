<cfoutput>
	<div class="heading">
		<h1>Get Started</h1>
	</div>
	
	<div class="deep-links span-15">
		<ul class="clearfix">
			<cfloop from="1" to="#ArrayLen(application.wheels.scaffoldNavigation)#" index="i">
				<cfif IsSimpleValue(application.wheels.scaffoldNavigation[i])>
					<li class="#application.wheels.scaffoldNavigation[i]#">
						<div class="quick-links">
							#scaffoldLinkTo(controller=application.wheels.scaffoldNavigation[i], action="new", text="Add a #humanize(singularize(application.wheels.scaffoldNavigation[i]))#")#
							#scaffoldLinkTo(controller=application.wheels.scaffoldNavigation[i], text="View All")#
						</div>
						<h3>
							#humanize(application.wheels.scaffoldNavigation[i])#
						</h3>
					</li>
				<cfelseif IsArray(application.wheels.scaffoldNavigation[i])>
					<li class="#application.wheels.scaffoldNavigation[i][1]#">
						<div class="quick-links">
							#scaffoldLinkTo(controller=application.wheels.scaffoldNavigation[i][1], action="new", text="Add a #humanize(singularize(application.wheels.scaffoldNavigation[i][1]))#")#
							#scaffoldLinkTo(controller=application.wheels.scaffoldNavigation[i][1], text="View All")#
						</div>
						<h3>
							#humanize(application.wheels.scaffoldNavigation[i][1])#
						</h3>
						<ul>
							<cfloop from="2" to="#ArrayLen(application.wheels.scaffoldNavigation[i])#" index="j">
								<li class="#application.wheels.scaffoldNavigation[i][j]#">
									<div class="quick-links">
										#scaffoldLinkTo(controller=application.wheels.scaffoldNavigation[i][j], action="new", text="Add a #humanize(singularize(application.wheels.scaffoldNavigation[i][j]))#")#
										#scaffoldLinkTo(controller=application.wheels.scaffoldNavigation[i][j], text="View All")#
									</div>
									<h4>
										#humanize(application.wheels.scaffoldNavigation[i][j])#
									</h4>
								</li>
							</cfloop>
						</ul>
					</li>
				</cfif>
			</cfloop>
		</ul>
	</div>
</cfoutput>