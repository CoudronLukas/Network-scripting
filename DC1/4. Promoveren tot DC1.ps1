#
# Promoveren tot DC1 met administrator credentials
#
Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
Test-ADDSForestInstallation -DomainName intranet.mijnschool.be -InstallDns
Install-ADDSForest -DomainName intranet.mijnschool.be -InstallDNS
Get-ADDomainController



#Install-ADDSDomainController -InstallDns -Credential (Get-Credential "Mijnschool\Administrator") -DomainName "intranet.mijnschool.be"