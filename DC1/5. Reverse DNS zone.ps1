#
# DNS aanpassen
#
$Dns = "172.20.0.2"
$Dns2 = "172.20.0.3"
# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | ? {$_.Status -eq "up"}
# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS

#
# Reverse DNS zone toevoegen
#
Add-DnsServerPrimaryZone -NetworkID “192.168.1.0/24” -ReplicationScope “Domain”


#
# Controleren of reverse DNS zone is toegevoegd
#
Get-DnsServerZone