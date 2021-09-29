#
# Promoveren tot DC1 met administrator credentials
#
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSDomainController -DomainName "intranet.mijnschool.be" -InstallDns:$true -Credential (Get-Credential "Mijnschool\administrator") -NoRebootCompletion:$true
Restart-Computer

Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012R2" -DomainName "intranet.mijnschool.be" -DomainNetbiosName "INTERNAL" -ForestMode "Win2012R2" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true