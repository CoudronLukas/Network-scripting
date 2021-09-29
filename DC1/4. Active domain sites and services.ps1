#
# Nieuwe site maken en subnet toevoegen in active domain sites and services
#
#https://adamtheautomator.com/active-directory-site/

New-ADReplicationSite -Name "Kortrijk" # nieuw SITE aanmaken
Get-AdReplicationSite Filter * | Select Name # kijken naar bestaande subnets
New-ADReplicationSubnet -Name "192.168.1.0/24" -Site Kortrijk #SUBNET toewijzen aan SITE