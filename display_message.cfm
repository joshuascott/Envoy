<cfswitch expression="#thisTag.executionMode#">
<cfcase value="start"></cfcase>
<cfcase value="End">
	<cfif isDefined('caller.messageStruct') AND isStruct(caller.messageStruct) AND isDefined('caller.messageStruct.color')>
		<cfset thisTag.GeneratedContent = '
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr valign="top">
					<td>
					<cfoutput>
						<font style="font-family: Arial, Helvetica, sans-serif;font-size: 11px; color:#caller.messageStruct.color#"><strong>#caller.messageStruct.text#</strong></font>
					 </cfoutput>
					</td>
				</tr>

				<tr><td colspan="4">&nbsp;</td></tr><!--- SPACER --->
			</table>
			
		'>
		<cfset StructClear(caller.messageStruct) />
	<cfelse>
		<cfset thisTag.GeneratedContent = ' '>
	</cfif> 
	</cfcase>
</cfswitch>