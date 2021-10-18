Import-Module ActiveDirectory
$ListGroups = Import-Csv C:\Users\Administrator\Documents\groups.csv -Delimiter ";"

ForEach($Group in $ListGroups){
    # Create New OU
    #Write-Host "Creating OU $($Objects.OU)"
    #New-ADOrganizationalUnit -Name "$($Objects.OU)"
    #Start-Sleep 2
    $path = $Group.Path
	$displayname = $Group.DisplayName
	$name = $Group.Name
    $desc = $Group.Description
    # Create AD Group
    Write-Host "Creating Group $name"
    New-ADGroup -Name "$($Objects.Name)" -SamAccountName "$($Objects.Group)" -GroupCategory 'Security' -GroupScope 'Global' -DisplayName "$($Objects.Group)" --Path "$((Get-ADOrganizationalUnit -Filter * | where {$_.Name -eq "$($Objects.OU)"}).DistinguishedName)"
    Start-Sleep 2
};   
	# Create AD User
    #Write-Host "Creating User $($Objects.User)"
    #New-ADUser -Name "$($Objects.User)" -Path "$((Get-ADOrganizationalUnit -Filter * | where {$_.Name -eq "$($Objects.OU)"}).DistinguishedName)"

    #Start-Sleep 2
    # Add AD User to Group
    #Write-Host "Adding User $($Objects.User) to Group $($Objects.Group)"
    #Add-ADGroupMember -Identity "$($Objects.Group)" -Members "$($Objects.User)" 