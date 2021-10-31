#Run dit op DC2

#variabelen
$Name = "Profile$" #$ op het einde = hidden
$Path = "C:\$Share_Name"
#aanmaken homefolder
mkdir "C:\Home"

#directory delen + iedereen full access
New-SmbShare -Name $Name -path $Path -FullAccess Everyone
#acl variable
$acl = Get-ACL -Path $Path
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
#authenticated users toevoegen met correcte rechten
$AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('Authenticated Users','ReadAndExecute','Allow')
$acl.AddAccessRule($AccessRule)


#alles committen
Set-Acl -Path $Path -AclObject $acl
