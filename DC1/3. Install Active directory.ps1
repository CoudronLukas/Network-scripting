#
# Installing active directory
#
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

#
# Creating active directory domain
#
Install-ADDSForest -DomainName "intranet.mijnschool.be" -DomainNetBiosName "Mijnschool" -InstallDns:$true -NoRebootCompletion:$true


Restart-Computer
