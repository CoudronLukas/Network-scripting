#https://docs.microsoft.com/en-us/powershell/module/smbshare/new-smbshare?view=windowsserver2019-ps
#https://stackoverflow.com/questions/25779423/powershell-to-set-folder-permissions/52945266
#https://stackoverflow.com/questions/26543127/powershell-setting-advanced-ntfs-permissions
$PC_MS = "WIN01-MS"

#Connecting to Remote PS on MS
$PC_Name = New-PSSession -ComputerName $PC_MS -Credential "INTRANET\Administrator"

Invoke-Command -Session $PC_Name -ScriptBlock {
	$Name = "Public"
	$Path = "C:\Public"

	#Path aanmaken
	mkdir $Path
	#Iedereen full access
	New-SmbShare -Name $Name -Path $Path -FullAccess Everyone
	#acl variabele
    $acl = Get-ACL -Path $Path
	#inheritance uitschakelen
    $acl.SetAccessRuleProtection($True, $False)
    #remove all from folder
    $acl.Access | %{$acl.RemoveAccessRule($_)}
	
	#---------------SET PERMISSIONS-------------------
	
    $AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('Personeel','Modify','Allow')
    $acl.AddAccessRule($AccessRule)
	
	$AccessRule = new-object system.security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM","FullControl","Allow")
    $acl.AddAccessRule($AccessRule)
	
	$AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('Authenticated Users','ReadAndExecute','Allow')
    $acl.AddAccessRule($AccessRule)
	
	#alles committen
    Set-Acl -Path $Share_Path -AclObject $acl
}