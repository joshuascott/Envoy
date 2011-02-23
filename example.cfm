<!--- Create Object and pass in the dictionary type --->
<cfset messageFactory = CreateObject("Component", "envoy.messageFactory").init("authentication","English") /> 
<!--- Call getMessage and pass in the message category and keyword --->
<cfset messageStruct = messageFactory.getMessage("login", "test") />

English:<br/>
<!--- This custom tag will display a message if it exists --->
<CF_DISPLAY_MESSAGE/> <br/>



<!--- Spanish --->
<cfset messageFactory = CreateObject("Component", "envoy.messageFactory").init("authentication","Spanish") /> 

<cfset messageStruct = messageFactory.getMessage("login", "test") />

Spanish:<br/>
<!--- This custom tag will display a message if it exists --->
<CF_DISPLAY_MESSAGE/> <br/>