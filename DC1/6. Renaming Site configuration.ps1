Get-ADForest | Format-List UPNSuffixes

Get-ADForest | Set-ADForest -UPNSuffixes @{add="exoip.com"}

Get-ADForest | Format-List UPNSuffixes