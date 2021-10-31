Get-ADForest | Set-ADForest -UPNSuffixes @{add="howest.be"} #voegt suffix toe
Get-ADForest | Format-List UPNSuffixes # geeft alle suffixen terug