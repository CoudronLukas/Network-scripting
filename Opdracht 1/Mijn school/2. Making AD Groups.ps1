Import-Module ActiveDirectory
$ListGroups = Import-Csv C:\Users\Administrator\Documents\groups.csv -Delimiter ";"

ForEach($Group in $ListGroups){
    $path = $Group.Path
	$name = $Group.Name
	$displayname = $Group.DisplayName
    $desc = $Group.Description
	$groupcategory = $Group.GroupCategory
	$groupscope = $Group.GroupScope
    # Create AD Group
    Write-Host "Creating Group $name"
    New-ADGroup -Name "$name" -Description "$desc" -GroupCategory "$groupcategory" -GroupScope "$groupscope" -DisplayName "$displayname" -Path "$path"
};   
	# Create AD User
    #Write-Host "Creating User $($Objects.User)"
    #New-ADUser -Name "$($Objects.User)" -Path "$((Get-ADOrganizationalUnit -Filter * | where {$_.Name -eq "$($Objects.OU)"}).DistinguishedName)"

    #Start-Sleep 2
    # Add AD User to Group
    #Write-Host "Adding User $($Objects.User) to Group $($Objects.Group)"
    #Add-ADGroupMember -Identity "$($Objects.Group)" -Members "$($Objects.User)" 