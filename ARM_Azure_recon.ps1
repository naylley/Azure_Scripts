```ps1
# Requires the Azure PowerShell cmdlets be installed.
# See https://github.com/Azure/azure-powershell/ for details.
# Before running the script:
#
* Run: Import-Module Azure
#
* Authenticate to Azure in PowerShell
#
* You may also need to run Set-ExecutionPolicy -Scope Process Unrestricted
# Show details of the current Azure subscription
Write-Output (" Subscription ","==============")
Write-Output ("Get-AzureRmContext")
$context = Get-AzureRmContext
$context
$context.Account
$context.Tenant
$context.Subscription
Write-Output ("Get-AzureRmRoleAssignment")
Get-AzureRmRoleAssignment
Write-Output ("", " Resources ","===========")
# Show the subscription's resource groups and a list of its resources
Write-Output ("Get-AzureRmResourceGroup")
Get-AzureRmResourceGroup | Format-Table ResourceGroupName,Location,ProvisioningState
Write-Output ("Get-AzureRmResource")
Get-AzureRmResource | Format-Table Name,ResourceType,ResourceGroupName
# Display Web Apps
Write-Output ("", " Web Apps ","==========")
Write-Output ("Get-AzureRmWebApp")
Get-AzureRmWebApp
# List virtual machines
Write-Output ("", " VMs ","=====")
$vms = Get-AzureRmVM
Write-Output ("Get-AzureRmVM")
$vms
foreach ($vm in $vms)
{
Write-Output ("Get-AzureRmVM -ResourceGroupName " + $vm.ResourceGroupName +
"-Name " + $vm.Name)
Get-AzureRmVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
Write-Output ("HardwareProfile:")
$vm.HardwareProfile
Write-Output ("OSProfile:")
$vm.OSProfile
Write-Output ("ImageReference:")
$vm.StorageProfile.ImageReference
}
# Show Azure Storage
Write-Output ("", " Storage ","=========")
$SAs = Get-AzureRmStorageAccount
Write-Output ("Get-AzureRmStorageAccount")
$SAs
foreach ($sa in $SAs)
{
Write-Output ("Get-AzureRmStorageAccountKey -ResourceGroupName " + $sa.ResourceGroupName +
" -StorageAccountName" + $sa.StorageAccountName)
Get-AzureRmStorageAccountKey -ResourceGroupName $sa.ResourceGroupName -StorageAccountName
$sa.StorageAccountName
}
# Get networking settings
Write-Output ("", " Networking ","============")
Write-Output ("Get-AzureRmNetworkInterface")
Get-AzureRmNetworkInterface
Write-Output ("Get-AzureRmPublicIpAddress")
Get-AzureRmPublicIpAddress
# NSGs
Write-Output ("", " NSGs ","======")
foreach ($vm in $vms)
{
$ni = Get-AzureRmNetworkInterface | where { $_.Id -eq $vm.NetworkInterfaceIDs }
Write-Output ("Get-AzureRmNetworkSecurityGroup for " + $vm.Name + ":")
Get-AzureRmNetworkSecurityGroup | where { $_.Id -eq $ni.NetworkSecurityGroup.Id }
}
# Show SQL information
Write-Output ("", " SQL ","=====")
foreach ($rg in Get-AzureRmResourceGroup)
{
foreach($ss in Get-AzureRmSqlServer -ResourceGroupName $rg.ResourceGroupName)
{
Write-Output ("Get-AzureRmSqlServer -ServerName" + $ss.ServerName +
" -ResourceGroupName " + $rg.ResourceGroupName)
Get-AzureRmSqlServer -ServerName $ss.ServerName -ResourceGroupName
$rg.ResourceGroupName
Write-Output ("Get-AzureRmSqlDatabase -ServerName" + $ss.ServerName +
" -ResourceGroupName " + $rg.ResourceGroupName)
Get-AzureRmSqlDatabase -ServerName $ss.ServerName -ResourceGroupName
$rg.ResourceGroupName
Write-Output ("Get-AzureRmSqlServerFirewallRule -ServerName" + $ss.ServerName +
" -ResourceGroupName " + $rg.ResourceGroupName)
Get-AzureRmSqlServerFirewallRule -ServerName $ss.ServerName -ResourceGroupName
$rg.ResourceGroupName
Write-Output ("Get-AzureRmSqlServerThreatDetectionPolicy -ServerName" +
$ss.ServerName + " -ResourceGroupName " + $rg.ResourceGroupName)
Get-AzureRmSqlServerThreatDetectionPolicy -ServerName
$ss.ServerName -ResourceGroupName $rg.ResourceGroupName
}
}
```
