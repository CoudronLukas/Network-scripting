#https://blog.netwrix.com/2018/04/18/how-to-manage-file-system-acls-with-powershell-scripts/
#Run dit op DC1
$PC_MS = "WIN01-MS"
$s = New-PSSession -ComputerName $PC_MS -Credential "INTRANET\Administrator" 
Invoke-Command -Session $s -ScriptBlock{
	#variabelen
	$Share_Name = "Home"
    $Share_Path = "C:\$Share_Name"
	#aanmaken homefolder
	mkdir "C:\Home"
	
    #directory delen + iedereen full access
    New-SmbShare -Name $Share_Name -path $Share_Path -FullAccess Everyone
    #acl variable
    $acl = Get-ACL -Path $Share_Path
    #iedereen uit folder verwijderen
    $acl.Access | %{$acl.RemoveAccessRule($_)}
    #overerving uitschakelen
    $acl.SetAccessRuleProtection($True, $False)
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
    Set-Acl -Path $Share_Path -AclObject $acl
	
}
