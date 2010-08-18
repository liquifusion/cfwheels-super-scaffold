<cfoutput><!---
---><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			#includePartial(partial="/layouts/head")#	
		</head>
		<body>
			<div id="wrapper">
				<div id="inner-wrapper">
				
					<div id="header">
						<div class="container">
							#includePartial(partial="/layouts/header")#
						</div>
					</div>
				
					<div id="navigation">
						<div class="container">
							#includePartial(partial="/layouts/navigation", params=params, cache=true)#
						</div>
					</div>
				
					<div id="body">
						<div class="container">
							<div class="span-24">
								<div id="loading-container">
									<div>
										<div class="message-container">
											#flashShow()#
										</div>
										<div class="bread-crumbs">
											#includePartial(partial="/layouts/breadcrumbs", breadcrumbs=params.breadcrumbs, cache=true)#
										</div>
										#includeContent()#
									</div>
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
