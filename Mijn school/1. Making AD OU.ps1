Import-Module ActiveDirectory
  
# Store the data from NewUsersFinal.csv in the $ListOU variable
$ListOU = Import-Csv C:\Users\Administrator\Documents\OU.csv ";" #Pad Aanpassen!!!


# Loop through each row containing user details in the CSV file
foreach ($OU in $ListOU) {
    
	$name = $OU.Name
    $path = $OU.Path
    $desc = $OU.Description
    $display = $OU.DisplayName

    #Account will be created in the OU provided by the $OU variable read from the CSV file
    New-ADOrganizationalUnit `
    -Name $name `
    -path $path `
    -Description $desc `
    -DisplayName $display`
}

Read-Host -Prompt "Press Enter to exit"