#
# Creating active directory domain
#
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "intranet.mijnschool.be" -DomainNetBiosName "Mijnschool" -InstallDns:$true -NoRebootCompletion:$true

#
# Promoveren tot DC1 met administrator credentials
#
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSDomainController -DomainName "intranet.mijnschool" -InstallDns:$true -Credential (Get-Credential "Mijnschool\administrator")


Restart-Computer
