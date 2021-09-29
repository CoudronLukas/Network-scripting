#
# Promoveren tot DC1 met administrator credentials
#
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSDomainController -DomainName "intranet.mijnschool.be" -InstallDns:$true -Credential (Get-Credential "Mijnschool\administrator") -NoRebootCompletion:$true
Restart-Computer