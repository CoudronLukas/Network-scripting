Import-Module ActiveDirectory
  
# Store the data from NewUsersFinal.csv in the $ListOU variable
$ListOU = Import-Csv C:\Users\Administrator\Documents\OU.csv ";" #Pad Aanpassen!!!


# Loop through each row containing user details in the CSV file
foreach ($OU in $ListOU) {
    $path = $OU.Path
	$display = $OU.Display
	$name = $OU.Name
    $desc = $OU.Description

    #Account will be created in the OU provided by the $OU variable read from the CSV file
    New-ADOrganizationalUnit -Name $name -path $path -Display $display -Description $desc 
    
}

Read-Host -Prompt "Press Enter to exit"