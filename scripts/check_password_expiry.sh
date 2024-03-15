# Function to print password expiration for a single user
function Check-User {
    param(
        [string]$Username
    )
    $ResourceGroupName = 'YourResourceGroup'  # Reemplaza con el nombre de tu grupo de recursos
    $VMName = 'YourVMName'  # Reemplaza con el nombre de tu máquina virtual
    $Command = "/usr/sbin/chage -l $Username | grep 'Password expires' | awk -F': ' '{print $2}'"
    $Output = Invoke-AzVMRunCommand -ResourceGroupName $ResourceGroupName -VMName $VMName -CommandId 'RunShellScript' -Script $Command
    $ExpirationDate = $Output.Value
    Write-Output "Password expiration for user $Username: $ExpirationDate"
}

# Check password expiration for each user provided as argument
$Usernames = @('davidv', 'darovero')  # Reemplaza con los nombres de usuario reales
foreach ($Username in $Usernames) {
    Check-User -Username $Username
}