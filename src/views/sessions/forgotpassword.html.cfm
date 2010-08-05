<cfoutput>
<p>Hi #user.firstName#,</p>
<p>Your email has been submitted for a new password to be generated. Your new password is <strong>#newPassword#</strong>.</p>
<p>
	We recommend that you 
	#scaffoldLinkTo(text="login now", action="new", onlyPath=false)#
	and update your password.
</p>
<p>
	Best wishes,<br />
	Super Scaffold	
</p>
</cfoutput>
