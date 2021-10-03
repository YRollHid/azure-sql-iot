[CmdletBinding(DefaultParameterSetName = 'None')]
param
(
  [String] [Parameter(Mandatory = $true)] $ServerName,
  [String] [Parameter(Mandatory = $true)] $ResourceGroup,
  [String] [Parameter(Mandatory = $true)] $ipAddress,
  [String] $AzureFirewallR1Name = "CloudAdminAllowedIPs",
  [String] $AzureFirewallR2Name = "AzDOAllowedIPs"
)
$agentIP = (New-Object net.webclient).downloadstring("http://checkip.dyndns.com") -replace "[^\d\.]"

$checkRule1 = Get-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroup -ServerName $ServerName -FirewallRuleName $AzureFirewallR1Name

$checkRule2 = Get-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroup -ServerName $ServerName -FirewallRuleName $AzureFirewallR2Name

if ( $checkRule1 ) {
    Write-Output "Rule has been added already!"
}
else
{
    New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroup -ServerName $ServerName -FirewallRuleName $AzureFirewallR1Name -StartIPAddress $agentIp -EndIPAddress $agentIP
}

if ( $checkRule2 ) {
    Write-Output "Rule has been added already!"
}
else {
    New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroup -ServerName $ServerName -FirewallRuleName $AzureFirewallR2Name -StartIPAddress $ipAddress -EndIPAddress $ipAddress
}