<cfcomponent displayname="MessageReader" hint="I take values passed from the MessageFactory and return the message package.">
	
	<cfset variables.dictionaryXml = "" />
	
	<cffunction name="init" access="public" hint="I configure and return this dictionary" output="false" returntype="messageReader">
		<cfargument name="pathToDictionary" hint="I am the path to the XML document this dictionary will use." required="yes" type="string" />
		
		<!--- <cftry> --->
			<cffile action="read" file="#arguments.pathToDictionary#" variable="dictionaryXml" />
			<cfset setDictionaryXml(XmlParse(dictionaryXml, false)) />
<!--- 		<cfcatch type="any">
			<cfthrow message="The XML file path provided is invalid or the dictionary file specified does not exist. If you are calling a valid dictionary file please check the spelling and location. If you are sure the file exists, please make sure that that the XML file is well-formed.">
		</cfcatch>
		</cftry> --->
		
		<cfreturn this />
	</cffunction>
	
	<!--- GetValue returns the text value inside a given node. --->
	<cffunction name="getValue" access="public" hint="I get a value from the dictionary" output="false" returntype="string">
		<cfargument name="element" hint="I am the path to the element to get from the dictionary. This is built in the CreateMessage() method." required="yes" type="string" />
		<cfset var node = 0 />
		
		<cftry>
			<cfset node = evaluate("getDictionaryXml().#arguments.element#") />
			<cfreturn node.xmltext />
			<cfcatch>
				<cfset returnMessage = "Message for [#arguments.element#] not defined.">
				<cfreturn returnMessage />
			</cfcatch> 
		</cftry>
	</cffunction>
	
	<!--- GetAttribute returns the specified attribute value inside a given node. --->
	<cffunction name="getAttribute" access="public" hint="I get a attribute from the dictionary" output="false" returntype="string">
		<cfargument name="element" hint="I am the path to the element to get from the dictionary.  IE: foo.bar to get dictionary/foo/bar" required="yes" type="string" />
		<cfargument name="attributeName"  required="true" type="String" />
		<cfset var node = 0 />
		
		<cftry>
			<cfset node = evaluate("getDictionaryXml().#arguments.element#") />
			<cfset attrib = arguments.attributeName />
				<cfreturn Evaluate("node.XMLAttributes.#attrib#") />
			<cfcatch>
				<cfreturn arguments.attributeName />
			</cfcatch> 
		</cftry>
	</cffunction>
	
	<!--- createMessage recieves the category and keyword from the factory and gets the values and packages them into a structure for return. --->
	<cffunction name="createMessage" access="public" returntype="struct">
		<cfargument name="category" type="string" required="true">
		<cfargument name="keyword" type="string" required="true">
		<cfset var message_text = "" />
		<cfset var message_color = "" />
		
		<cfset messageStruct = StructNew() />
		<!--- Reserved words (Debug and Exception --->
		<cfif arguments.category is "exception">
			<cfset structInsert(messageStruct, 'color', "red") />
			<cfset structInsert(messageStruct, 'text', '#arguments.keyword#') />
		<cfelseif arguments.category is "debug">
			<cfset structInsert(messageStruct, 'color', "black") />
			<cfset structInsert(messageStruct, 'text', '#arguments.keyword#') />
		<cfelse>
		<!--- Normal --->
		<cfset pathToMessage = 'libraries.' & arguments.category & '.' & arguments.keyword />
			<cfscript>
			structInsert(messageStruct, 'text', this.getValue(pathToMessage));
			if (this.getAttribute(pathToMessage, "color") is not "color"){
				structInsert(messageStruct, 'color', this.getAttribute(pathToMessage, "color"));	
			}
			else{
				structInsert(messageStruct, 'color', "red");	
			}
			</cfscript>
		</cfif>
		<cfreturn messageStruct/>
	</cffunction>
	
	<!--- dictionaryXml --->
    <cffunction name="setDictionaryXml" access="private" output="false" returntype="void">
       <cfargument name="dictionaryXml" hint="I am the xml from the dictionary" required="yes" type="string" />
       <cfset variables.dictionaryXml = arguments.dictionaryXml />
    </cffunction>
    
	<cffunction name="getDictionaryXml" access="private" output="false" returntype="string">
       <cfreturn variables.dictionaryXml />
    </cffunction>
  
</cfcomponent>