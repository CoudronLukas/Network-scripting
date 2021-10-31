Add-WindowsFeature AD-Domain-Services
Install-ADDSDomainController 
	-CreateDnsDelegation:$false `
	-DatabasePath 'C:\Windows\NTDS' `
	-DomainName 'intranet.mijnschool.be' `
	-InstallDns:$true `
	-LogPath 'C:\Windows\NTDS' `
	-NoGlobalCatalog:$false `
	-SiteName 'resto.mijnschool' `
	-SysvolPath 'C:\Windows\SYSVOL' `
	-NoRebootOnCompletion:$true `
	-Force:$true `

Restart-Computer