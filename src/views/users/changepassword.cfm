<cfoutput>
	<div class="new">
	
		<div class="heading">
			<h1>Update your Password</h1>
		</div>
		
		<div class="form">
			#scaffoldStartFormTag(action="save-password")#

				#scaffoldTextField(label="New Password", objectName="user", property="authenticationToken", class="text required")#
		
				<p class="controls">#buttonTag(content="<span>Update</span>", type="submit", class="interface-button save")# <span>or #scaffoldLinkToBack(text="cancel", title="cancel", class="cancel")#</span></p>
			
			#endFormTag()#
		</div>
	</div>
</cfoutput>