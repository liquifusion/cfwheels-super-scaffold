<cfoutput>
	<h1>I Forgot my Password!</h1>
	
	#flashShow()#
	
	#scaffoldStartFormTag(action="retrieve")#
	
		#scaffoldTextField(objectName="user", property="emailAddress", class="text emailAddress")#
		
		<p class="controls">
			#buttonTag(content="<span>Retrieve</span>", type="submit", class="interface-button login")# 
			<span>or #scaffoldLinkTo(action="new", text="I just remembered it!")#</span>
		</p>
	
	#endFormTag()#
</cfoutput>