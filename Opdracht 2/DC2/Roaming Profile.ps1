#https://community.spiceworks.com/topic/491222-powershell-get-all-users-in-an-adgroup-with-the-displayname
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.1

#alle users in AD
$Users = Get-ADGroupMember -identity "Personeel"
$Path = "\\Win02-DC2\Profiles$"
Foreach($User in $Users){
	#maak path met de username
	$User_Name = (Get-ADUser -Filter *).Name
	$New_Path = $Path + $User_Name
	#make a new directory
	New-Item -Path $New_Path -ItemType "directory"
	
	#acl variable
	$acl = Get-ACL -Path $New_Path
	#iedereen uit folder verwijderen
	$acl.Access | %{$acl.RemoveAccessRule($_)}
	#overerving uitschakelen
	$acl.SetAccessRuleProtection($True, $False)

	#---------------SET PERMISSIONS-------------------

	#BUILTIN\Administrators toevoegen 
	$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators","FullControl","Allow")
	$acl.SetAccessRule($AccessRule)
	#NT AUTHORITY\SYSTEM toevoegen
	$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM","FullControl","Allow")
	$acl.SetAccessRule($AccessRule)
	#user toevoegen met correcte rechten
	$AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('intranet\$User','modify','Allow')
	$acl.AddAccessRule($AccessRule)


	#alles committen
	Set-Acl -Path $Path -AclObject $acl
}