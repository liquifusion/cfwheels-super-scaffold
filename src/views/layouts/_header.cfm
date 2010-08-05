<cfoutput>					
	<div class="links">
		<span class="welcome">Welcome back, <strong>#sessionCache("user").firstName#</strong>.</span>
		<!---
		#scaffoldLinkTo(controller="", text="Documentation", title="Documentation")#
		/ 
		--->
		#linkTo(route="superscaffold", controller="users", action="change-password", text="Change Password", title="Change Password")#
		/ #scaffoldLinkTo(controller="sessions", action="destroy", text="Logout", title="Logout")#
	</div>
	
	<div class="logo">
		<h2>#application.wheels.scaffoldTitle#</h2>
	</div>					
</cfoutput>