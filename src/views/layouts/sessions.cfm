<cfoutput><!---
---><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			#includePartial(partial="/layouts/head")#	
		</head>
		<body class="sessions">
			<div id="wrapper">
				<div id="inner-wrapper">
				
					<div id="body">
						<div class="container">
							<div class="span-12 last">
								<div style="padding:0 1.5em;">
									#includeContent()#
								</div>
							</div>
						</div>
						<div class="container bottom"></div>
					</div>
				
					<div id="footer">
						<div class="container">
							#includePartial(partial="/layouts/footer", cache=true)#
						</div>
					</div>
					
				</div>
			</div>
		</body>
	</html>
</cfoutput>
