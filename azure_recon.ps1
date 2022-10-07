```ps1
# Requires the Azure PowerShell cmdlets be installed.
# See https://github.com/Azure/azure-powershell/ for details.
# Before running the script:
#
* Run: Import-Module Azure
#
* Authenticate to Azure in PowerShell
#
* You may also need to run: Set-ExecutionPolicy -Scope Process Unrestricted
# Show subscription metadata
Write-Output (" Subscription ","==============")
Write-Output ("Get-AzureSubscription -Current")
Get-AzureSubscription -Current
# Display websites
Write-Output ("", " Websites ","==========")
$sites = Get-AzureWebsite
Write-Output ("Get-AzureWebsite")
$sites
foreach ($site in $sites)
{
Write-Output ("Get-AzureWebsite -Name " + $site.Name)
Get-AzureWebsite -Name $site.Name
}
# View virtual machines
Write-Output ("", " VMs ","=====")
$vms = Get-AzureVM
Write-Output ("Get-AzureVM")
$vms
foreach ($vm in $vms)
{
Write-Output ("Get-AzureVM -ServiceName " + $vm.ServiceName)
Get-AzureVM -ServiceName $vm.ServiceName
}
# Enumerate Azure Storage
Write-Output ("", " Storage ","=========")
$SAs = Get-AzureStorageAccount
Write-Output ("Get-AzureStorageAccount")
$SAs
foreach ($sa in $SAs)
{
Write-Output ("Get-AzureStorageKey -StorageAccountName" + $sa.StorageAccountName)
Get-AzureStorageKey -StorageAccountName $sa.StorageAccountName
}
# Get networking settings
Write-Output ("", " Networking ","============")
Write-Output ("Get-AzureReservedIP")
Get-AzureReservedIP
Write-Output ("", " Endpoints ","===========")
# Show network endpoints for each VM
foreach ($vm in $vms)
{
Write-Output ("Get-AzureEndpoint " + $vm.ServiceName)
Get-AzureEndpoint -VM $vm
}
# Dump NSGs
Write-Output ("", " NSGs ","======")
foreach ($vm in $vms)
{
Write-Output ("NSG for " + $vm.ServiceName + ":")
Get-AzureNetworkSecurityGroupAssociation -VM $vm -ServiceName $vm.ServiceName
}
# Display SQL information
Write-Output ("", " SQL ","=====")
$sqlServers = Get-AzureSqlDatabaseServer
Write-Output ("Get-AzureSqlDatabaseServer")
$sqlServers
foreach ($ss in $sqlServers)
{
Write-Output ("Get-AzureSqlDatabase -ServerName " + $ss.ServerName)
Get-AzureSqlDatabase -ServerName $ss.ServerName
Write-Output ("Get-AzureSqlDatabaseServerFirewallRule -ServerName " + $ss.ServerName)
Get-AzureSqlDatabaseServerFirewallRule -ServerName $ss.ServerName
}
```
