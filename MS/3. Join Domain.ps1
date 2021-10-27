#Run op DC1
$s = New-PSSession -ComputerName "WIN01-MS" -Credential "INTRANET\Administrator" 
Invoke-Command -Session $s -ScriptBlock{
    $Domain = "intranet.mijnschool.be"
    Add-Computer -DomainName $Domain -Restart
}
