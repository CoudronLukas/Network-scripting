#
# Reverse DNS zone toevoegen
#
Add-DnsServerPrimaryZone -NetworkID “192.168.1.0/24” -ReplicationScope “Mijnschool”


#
# Controleren of reverse DNS zone is toegevoegd
#
Get-DnsServerZone