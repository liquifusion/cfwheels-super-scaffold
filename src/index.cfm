<cfif StructKeyExists(url, "install") and IsBoolean(url.install) and url.install>
	<cfinclude template="install.cfm" />
</cfif>

<cfif StructKeyExists(url, "createzips") and IsBoolean(url.createzips) and url.createzips>
	<cfinclude template="createzips.cfm" />
</cfif>

<cfoutput>#flashMessages()#</cfoutput>

<h1>Super Scaffold</h1>

<p>
	The super scaffold plugin allows you to rapidly create an AWESOME looking admin area in <strong>1/10th</strong> of the time it would normally take to create something with a 
	comparable feature set. Features include:
</p>

<ul>
	<li>An ajax interface for your CRUD operations.</li>
	<li>Automatic handling of association data in your list, view and edit screens.</li>
	<li>Sorting, searching and pagination on your listing screens.</li>
	<li>Full functionality without javascript.</li>
	<li>Override everything from displaying data to form fields, templates and whole actions.</li>
	<li>Guaranteed NOT to work in IE6, FF2!</li>
	<li>Guaranteed to work in IE 7-8, FF3.x, Safari 4-5 and Chrome 4-5.</li>
</ul>

<h2>WARNING</h2>

<p>
	If you do not like to follow <a href="http://cfwheels.org/docs/chapter/conventions">wheels conventions</a> in your database, this plugin is probably <strong><em><u>NOT for you</u></em></strong>.
	On the other hand, if you do like following the conventions, this plugin will save your a shit load of time creating and admin interface
	for your database.
</p>

<h2>Installation</h2>

<p>
	Please make sure you are installing this plugin in a fresh version of wheels 1.1 or greater. In order for the plugin to fully work, you will need to click the
	link below to add the necessary assets into your app. I know, I know, the list below is everything that is going to happen.
</p>

<ul>
	<li>Your <code>config/app.cfm</code> file will be updated with a mapping to the controllers folder.</li>
	<li>Your <code>config/routes.cfm</code> file will be updated with an inlcude to <code>plugins/superscaffold/superscaffold/config/routes.cfm</code> so the
		the scaffolding routes are added to your application.</li>
	<li>Your <code>events/onapplicationstart.cfm</code> file will be updated with an inlcude to <code>plugins/superscaffold/superscaffold/events/onapplicationstart.cfm</code> so the
		the scaffolding bundles for css and js can be created.</li>
	<li>The folder <code>scaffold</code> will be added to your <code>images</code> folder with images that are used in the admin interface. Don't worry, we only use two images files since
		we sprited all of the images together.</li>
	<li>The folder <code>scaffold</code> will be added to your <code>javascripts</code> folder with all of the javascript files necessary to make the admin area as slick as ice.</li>
	<li>The folder <code>scaffold</code> will be added to your <code>stylesheets</code> folder with all of the css necessary to get you up and running in minutes, not weeks.</li>
</ul>

<p>
	Please note that these assets will only be added to their specific locations if the code or assets folder does not already exist. If you are upgrading, make sure to remove the old assets
	before installing again.
</p>

<h2><cfoutput><a href="#get('webPath')##ListLast(request.cgi.script_name, '/')#?controller=wheels&amp;action=wheels&amp;view=plugins&amp;name=superscaffold&amp;install=true">Click HERE to install the Super Scaffold assets and includes</a></cfoutput></h2>

<p>&nbsp;</p>

<h2>Read the Documentation</h2>

<p>Talk about documentation on github.</p>

<!---
<h2>New Methods</h2>
<ul>
	<li>generateBundle
		<ul>
			<li><strong>type</strong> - the type of files your are compressing together - can be "js" or "css"</li>
			<li><strong>source/sources</strong> - the files you would like to be compressed together</li>
			<li><strong>bundle</strong> - the name of the bundled file - it may contain a folder structure ex. "bundles/core"</li>
			<li><strong>compress</strong> - whether to have the YUI compressor compress the bundled files, defaults to false</li>
		</ul>
	</li>
</ul>

<p>
	Use the <code>generateBundle()</code> method in /events/onapplicationstart.cfm to specify the bundles that you want to create when in testing or production mode.
	The method should only be used here to ensure that your bundles are created before the application starts serving requests. 
<p>
</p>	
	The source/sources argument you specify for this method will be saved by the asset bundler. In your layout file, you should only need to call <code>javaScriptIncludeTag()</code> or <code>styleSheetLinkTag()</code>
	with the proper bundle name and the asset bundler will decide what link or script tags to produce based on your environment settings. An example is below.
</p>

<pre>
... in /events/onApplicationStart.cfm

&lt;cfset generateBundle(type="css", bundle="bundles/core", compress=true, sources="screen,liquid,style") /&gt;	

... in your layout file - maybe /views/layout.cfm

#styleSheetLinkTag(bundle="bundles/core")#
</pre>
<p>
	When in the design, development and maintenance the code about will output <code>&lt;link /&gt;</code> tags for each source listed. In the testing and production evnironments
	the same code will produce one <code>&lt;link /&gt;</code> tag pointing to /sytlesheets/bundles/core.css.
</p>

<h2>Overridden Methods</h2>
<ul>
	<li>styleSheetLinkTag
		<ul>
			<li><strong>sources</strong> - a list of stylesheet files that you would like included on the page.</li>
			<li><strong>type</strong> - The type of file. Defaults to <code>application.wheels.styleSheetLinkTag.type</code>.</li>
			<li><strong>media</strong> - The media type to apply the CSS to. Defaults to <code>application.wheels.styleSheetLinkTag.media</code></li>
			<li><strong>bundle</strong> - the name of the bundled file to use in testing and production. If the bundle is specified, you should not need to list any sources.</li>
		</ul>
	</li>
	<li>javaScriptIncludeTag</li>
		<ul>
			<li><strong>sources</strong> - a list of stylesheet files that you would like included on the page.</li>
			<li><strong>type</strong> - The type of file. Defaults to <code>application.wheels.javaScriptIncludeTag.type</code>.</li>
			<li><strong>bundle</strong> - the name of the bundled file to use in testing and production. If the bundle is specified, you should not need to list any sources.</li>
		</ul>
</ul>

<h2>How to Use</h2>

<p>
	Once installed, simply use the functions listed above with the proper parameters. When calling these methods, please make sure to specify argument names to keep 
	conflicts from occurring when not using the plugin. For example, do <code>styleSheetLinkTag(sources="core,layout,theme", bundle="all")</code>.
</p> 
<p>
	When in the Testing or Production environments, the plugin will bundle your assets as specified. The bundling will occur onApplicationStart() or when you
	add the reload parameter into the URL and reload the application.
</p>	
<p>
	If you would like to create multiple bundles, simply call the <code>generateBundle()</code> method multiple times using different bundle names. Please make sure 
	to not repeat bundle names as this will have unintended consequences.
</p>
<p>
	Once a bundle is created it will not be recreated until the parameter "reload" is detected in the url. This gives you
	complete control over when the bundle is rebuilt. This is also done to limit file system access while serving bundles in a production
	environment.
</p>

<h2>Shared Hosting Environments</h2>

<p>
	I am also pleased to note that this plugin has no dependency on the internal Coldfusion objects so it can be used in shared hosting enviroments where the setting
	"Disable access to internal ColdFusion Java components" is turned on.
</p>

<h2>Thanks</h2>

<p>
	A big shout out goes to <a href="http://www.compoundtheory.com/">Mark Mandel</a> who is the creator of <a href="http://javaloader.riaforge.org/">JavaLoader</a> which
	is used in this project. Also, a big thank you to the <a href="http://developer.yahoo.com/yui/">YUI</a> for creating the awesome
	<a href="http://developer.yahoo.com/yui/compressor/">YUI compressor</a>. And last but not least, a big thanks to the <a href="http://cfwheels.org/community/core-team">wheels core
	 team</a> for creating such an awesome framework.
</p>

<h2>Road Map</h2>
<p>I would like to add the following features to the plugin to make it to a 1.0 release.</p>
<ul>
	<li>Testing and bug fixes.</li>
</ul>

<h2>Uninstallation</h2>
<p>To uninstall this plugin simply delete the <tt>/plugins/AssetBundler-0.9.zip</tt> file.</p>

<h2>Credits</h2>
<p>This plugin was created by <a href="http://iamjamesgibson.com">James Gibson</a>.</p>


<p><a href="<cfoutput>#cgi.http_referer#</cfoutput>">&lt;&lt;&lt; Go Back</a></p>
--->

<h2>Developer Links</h2>
<cfoutput>
<p>
	The link below will zip up all of the assets back into the <code>plugins/superscaffold/assets directory</code>.<br />
	<a href="#get('webPath')##ListLast(request.cgi.script_name, '/')#?controller=wheels&amp;action=wheels&amp;view=plugins&amp;name=superscaffold&amp;createzips=true">Create asset zips</a>
</p>
</cfoutput>