#https://hinchley.net/articles/configure-load-balanced-dhcp-servers-using-powershell/
Install-WindowsFeature DHCP
Add-DhcpServerInDC
Add-DhcpServerSecurityGroup
New-ADUser 
	-Name dhcp-dns 
	-SamAccountName dhcp-dns 
	-DisplayName dhcp-dns 
	-UserPrincipalName dhcp-dns@lab.hinchley.net 
	-Path "ou=Service Accounts,dc=lab,dc=hinchley,dc=net" 
	-AccountPassword (Read-Host "Password" -AsSecureString) 
	-ChangePasswordAtLogon $false -Enabled $true
	
	
Set-DhcpServerDnsCredential -Credential LAB\dhcp-dns
Set-DhcpServerv4OptionValue -DnsDomain lab.hinchley.net -DnsServer 10.0.0.10, 10.0.0.11 -Router 10.0.0.1
Add-DhcpServerv4Scope -Name LAB -StartRange 10.0.0.220 -EndRange 10.0.0.239 -SubnetMask 255.255.255.0 -ComputerName WINSTON
Add-DhcpServerv4Failover -ComputerName WINSTON -PartnerServer GEORGE -Name WINSTON-GEORGE -ScopeId 10.0.0.0 -LoadBalancePercent 50 -SharedSecret (Read-Host "Password") –Force

Restart-Service DHCPServer
