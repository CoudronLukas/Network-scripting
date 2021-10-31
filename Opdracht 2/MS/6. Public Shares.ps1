#RUN OP DC2
$PC_MS = "WIN01-MS"

$Path = "\\Dc-1\netlogon\logon.bat"
$Content = "\net use P: \\Win02-MS\Public"
#kijk of logon.bat al aangemaakt is
if(Test-Path $Path){
	Write-Host "Logon.bat bestaat al"
}
#stop het script als logon.bat niet bestaat
else{
	Write-Host "Logon.bat bestaat nog niet!"
	Write-Host "Zorg dat logon.bat aangemaakt is"
	exit 1
}
	
#shares resource   
Add-Content -Path $Path -Value $Content



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