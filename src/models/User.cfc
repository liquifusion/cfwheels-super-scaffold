<cfcomponent extends="Model" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			property(name="display", sql="CONCAT_WS(' ', users.firstName, users.lastName)", label="Name", displayOn="list,view,delete", sorting="lastName", fieldset="Basic Details");
			property(name="firstName", label="First Name", displayOn="new,edit,search", fieldset="Basic Details");
			property(name="lastName", label="Last Name", displayOn="new,edit,search");
			property(name="emailAddress", label="Email Address", displayOn="list,search,view,new,edit,delete", description="ex. john.doe@yourcompany.com", fieldset="Authentication Details");
			property(name="authenticationToken", label="Password", mask="password", displayOn="view,new,edit,delete");
			belongsTo(name="role", label="Role", displayOn="list,view,new,edit,delete", sorting="roles.title");
			
			validatesPresenceOf(property="roleId", message="Please select a role");
			validatesFormatOf(property="emailAddress", type="email", message="Improperly formatted email address", allowBlank=true);
			validatesUniquenessOf(property="emailAddress", allowBlank=true);
		</cfscript>
	</cffunction>
	
	<cffunction name="authenticate" access="public" output="false" returntype="boolean">
		<cfargument name="authenticationToken" type="string" required="true" />
		<cfscript>
			var returnValue = false;
			
			if (Compare(arguments.authenticationToken, this.authenticationToken) == 0)
				returnValue = true;
		</cfscript>
		<cfreturn returnValue />
	</cffunction>
	
	<cffunction name="generateNewPassword" output="false" access="public">
		<cfscript>
			var loc = {};
			loc.newPassword = LCase(Right(CreateUUID(), 6));
			this.authenticationToken = loc.newPassword;
		</cfscript>
		<cfreturn loc.newPassword />
	</cffunction>

</cfcomponent>