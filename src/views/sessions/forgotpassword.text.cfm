<cfoutput>
Hi #user.firstName#,

Your email has been submitted for a new password to be generated. Your new password is #newPassword#.

We recommend that you click or copy the link below into your browser and update your password.

#URLFor(route="superscaffold", controller="sessions", text="login now", action="new", onlyPath=false)#

Best wishes,
Super Scaffold	
</cfoutput>