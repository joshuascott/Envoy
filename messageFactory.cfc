<cfcomponent displayname="messageFactory" hint="I handle all service message for the system.">

	<cffunction name="init" access="public" hint="I configure the Message Factory." output="false" returntype="messageFactory">
		<cfargument name="DictionaryName" hint="I am the name of the dictionary library." required="false" type="string" />
		<cfargument name="DictionaryLanguage" hint="I am the language to the XML document this dictionary will use." required="false" type="string" default="English" />
		<cfset var basePath = "" />
		<cfset var pathToDictionary = "" />

		<cfif len(arguments.DictionaryName)>
			<!--- Determine the base path dynamically --->
			<cfset basePath = Reverse(mid(Reverse(GetCurrentTemplatePath()),19,len(GetCurrentTemplatePath()))) />
			<!--- Create the pathToDictionary --->
			<cfset pathToDictionary = basePath & 'dictionary\' & arguments.DictionaryLanguage & '\' & arguments.DictionaryName & 'Dictionary.xml' />

			<!---- Inialize the messageReader with the correct dictionary --->
			<cfset messageReader = CreateObject("Component", "messageReader").init(pathToDictionary) />
		</cfif>

		<cfreturn this />
	</cffunction>

	<!---  GetMessage is called by the application it returns the structure created my CreateMessage inside of the messageReader --->
	<cffunction name="getMessage" output="true" access="public">
		<cfargument name="category" type="string" required="true">
		<cfargument name="keyword" type="string" required="true">
		<cfset var message = "" />
			<cfset message = messageReader.createMessage(arguments.category, arguments.keyword) />
		<cfreturn message />
	</cffunction>

</cfcomponent>