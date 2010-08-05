<cfcomponent extends="controllers.Controller" output="false">

	<cffunction name="init" access="public" output="false" returntype="void">
		<cfscript>
			usesLayout(template="/layouts/sessions", useDefault=false);
		</cfscript>
	</cffunction>
	
	<cffunction name="new" access="public" output="false" returntype="void">
		<cfscript>
			user = model("user").new();
		</cfscript>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="void">
		<cfscript>
			if (!StructKeyExists(params, "user") || !StructKeyExists(params.user, "emailAddress") || !StructKeyExists(params.user, "authenticationToken"))
				$returnToLogin(success=false);
		
			user = model("user").findOne(where="emailAddress = '#params.user.emailAddress#'", include="role");
			
			if (!IsObject(user))
				$returnToLogin(success=false);
				
			if (!user.authenticate(authenticationToken=params.user.authenticationToken))
				$returnToLogin(success=false);
				
			sessionCache("user", user);
			
			$returnToLogin(success=true);
		</cfscript>
	</cffunction>
	
	<cffunction name="forgot" access="public" output="false" returntype="void">
		<cfscript>
			user = model("user").new();
		</cfscript>
	</cffunction>
	
	<cffunction name="retrieve" access="public" output="false" returntype="void">
		<cfscript>
			if (!StructKeyExists(params, "user") || !StructKeyExists(params.user, "emailAddress"))
				$returnToForgot(success=false);
		
			user = model("user").findOne(where="emailAddress = '#params.user.emailAddress#'", include="role");
			
			if (!IsObject(user))
				$returnToForgot(success=false);
			
			newPassword = user.generateNewPassword();
			
			if (user.save())
			{
				sendEmail(
					  from = "admin@#request.cgi.server_name#"
					, template = "forgotpassword.text,forgotpassword.html"
					, layout = "/layouts/email"
					, to = user.emailAddress
					, subject = "We have reset your password"
					, user = user
					, newPassword = newPassword);
				
				$returnToForgot(success=true);
			}
			else
			{
				$returnToForgot(success=false);
			}
			
		</cfscript>
	</cffunction>
	
	<cffunction name="destroy" access="public" output="false" returntype="void">
		<cfscript>
			StructClear(session);
			flashInsert(success="You have been successfully logged out.");
			scaffoldRedirectTo(controller="sessions", action="new");
		</cfscript>
	</cffunction>
	
	<cffunction name="$returnToLogin" access="private" output="false" returntype="void">
		<cfargument name="success" type="boolean" required="true" />
		<cfscript>
			if (arguments.success)
			{
				flashInsert(success="Welcome back #user.firstName#! You have successfully logged in.");
				
				if (StructKeyExists(params, "return"))
					$location(url=params.return, addtoken=false);
				
				scaffoldRedirectTo(controller="");
			}
			else
			{
				flashInsert(error = "The email address and/or password were not correct.");
				scaffoldRedirectTo(controller="sessions", action="new");
			}	
		</cfscript>
	</cffunction>
	
	<cffunction name="$returnToForgot" access="private" output="false" returntype="void">
		<cfargument name="success" type="boolean" required="true" />
		<cfscript>
			if (arguments.success)
			{
				flashInsert(success="Your password has been reset and emailed to your email address!");
				scaffoldRedirectTo(action="new");
			}
			else
			{
				flashInsert(error = "There was an error reseting your password.");
				scaffoldRedirectTo(action="forgot");
			}	
		</cfscript>
	</cffunction>

</cfcomponent>


