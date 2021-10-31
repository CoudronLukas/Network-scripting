# Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
  
# Store the data from NewUsersFinal.csv in the $ADUsers variable
$ADUsers = Import-Csv C:\Users\Administrator\Documents\user_accounts.csv -Delimiter ";" #Pad Aanpassen!!!

# Define UPN
$UPN = "intranet.mijnschool.be"

#logon.bat 
$Name = "logon.bat"
$Path = "\\Dc-1\netlogon\logon.bat"

if (Test-Path $Path){
    Write-Host "file has already been made"
} 
else {
    #als logon.bat nog niet bestaat
    New-Item -Path "\\Dc-1\netlogon\" -Name $Name

    #share koppelen door text te inserten in de file
    "@echo off" | Out-File -FilePath $Path
    "net use H: \\Win02-MS\Home" | Out-File -FilePath $Path -Append
}


# Loop through each row containing user details in the CSV file
foreach ($User in $ADUsers) {

    #Read user data from each field in each row and assign the data to a variable as below
    $Name = $User.Name
    $SamAccountName = $User.SamAccountName
    $DisplayName = $User.DisplayName
    $GivenName = $User.GivenName
    $Surname = $User.Surname
    $Path = $User.Path #This field refers to the OU the user account is to be created in
    $HomeDrive = $User.HomeDrive
    $AccountPassword = $User.AccountPassword
    $HomeDirectory = $User.HomeDirectory
    $ScriptPath = $User.ScriptPath

    # Check to see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        # If user does exist, give a warning
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {

        # User does not exist then proceed to create the new user account
        # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser `
		    -Name $Name `
            -SamAccountName $SamAccountName `
            -Enabled $True `
            -DisplayName $DisplayName `
			-GivenName $GivenName `
			-Surname $Surname `
            -Path $Path `
            -HomeDrive $HomeDrive `
            -AccountPassword $AccountPassword `
			-HomeDirectory $HomeDirectory `
			-ScriptPath $ScriptPath

        # If user is created, show message.
        Write-Host "The user account $username is created." -ForegroundColor Cyan
    }
}

Read-Host -Prompt "Press Enter to exit"