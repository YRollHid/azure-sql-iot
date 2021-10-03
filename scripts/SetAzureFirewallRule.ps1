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
New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroup -ServerName $ServerName -FirewallRuleName $AzureFirewallR1Name -StartIPAddress $agentIp -EndIPAddress $agentIP
New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroup -ServerName $ServerName -FirewallRuleName $AzureFirewallR2Name -StartIPAddress $ipAddress -EndIPAddress $ipAddress