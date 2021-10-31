#
# Creating active directory domain
#
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "intranet.mijnschool.be" -DomainNetBiosName "Mijnschool" -InstallDns:$true -NoRebootCompletion:$true
Restart-Computer



