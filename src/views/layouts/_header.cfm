<cfoutput>					
	<div class="links">
		<span class="welcome">Welcome back, <strong>James</strong>.</span>
		#scaffoldLinkTo(controller="", text="Documentation", title="Documentation")#
		/ #scaffoldLinkTo(controller="", text="Change Password", title="Change Password")#
		/ #scaffoldLinkTo(controller="", text="Logout", title="Logout")#
	</div>
	
	<div class="logo">
		<h2>#application.superscaffold.title#</h2>
	</div>					
</cfoutput>