<cfoutput>
	<h1>Login</h1>
	
	#flashShow()#
	
	<cfif StructKeyExists(params, "firstinstall") and params.firstinstall eq "$kc7g0b!">
		<div class="success">
			Your install was successful. Login with admin@admin.com and the password "admin". (without the quotes)
		</div>
	</cfif>
	
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