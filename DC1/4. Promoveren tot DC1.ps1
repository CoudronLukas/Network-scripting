#
# Promoveren tot DC1 met administrator credentials
#
Install-ADDSDomainController -InstallDns -Credential (Get-Credential "Mijnschool\Administrator") -DomainName "intranet.mijnschool.be"