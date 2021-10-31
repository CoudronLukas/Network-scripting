https://4sysops.com/archives/analyze-dhcp-server-with-powershell/


$Devices = Get-DhcpServerv4Lease -ScopeId 192.168.1.0
foreach($Device in $Devices){
	$Mac = $Device.ClientId
	
	$MacByteArray = $Mac -split "[:-]" | ForEach-Object { [Byte] "0x$_"}
	[Byte[]] $MagicPacket = (,0xFF * 6) + ($MacByteArray  * 16)
	$UdpClient = New-Object System.Net.Sockets.UdpClient
	$UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
	$UdpClient.Send($MagicPacket,$MagicPacket.Length)
	$UdpClient.Close()
}