Import-Module ActiveDirectory

$AddUser = Import-Csv C:\Users\Administrator\Documents\user_members.csv -Delimiter ";"

foreach($User in $AddUser){
	$Group = $User.Identity
	$Member = $User.Member
	Write-Host $Group
	Write-Host $Member
	
	Add-ADGroupMember -Identity $Group -Members $Member
	Get-ADGroupMember $Group
	Write-Host -ForegroundColor Green "Group $Group modified!"
}