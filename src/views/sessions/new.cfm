<cfoutput>
	<h1>Login</h1>
	
	#flashShow()#
	
	#scaffoldStartFormTag(action="create")#
			
		<cfif StructKeyExists(params, "return")>
			#hiddenFieldTag(name="return", value=HTMLEditFormat(stripTags(params.return)))#
		</cfif>
		
		#scaffoldTextField(objectName="user", property="emailAddress", class="text emailAddress")#
	
		#scaffoldPasswordField(objectName="user", property="authenticationToken", class="text emailAddress")#
		
		<p class="controls">
			#buttonTag(content="<span>Login</span>", type="submit", class="interface-button login")# 
			<span>or #scaffoldLinkTo(action="forgot", text="I forgot my password!")#</span>
		</p>
	
	#endFormTag()#
</cfoutput>