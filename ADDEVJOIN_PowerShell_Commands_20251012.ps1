# Client Preparation
$myDomain="dariens.tips"
ipconfig /all
Get-DnsClientServerAddress -AddressFamily IPv4,IPv6
nltest /dsgetdc:$myDomain
Start-Service w32time
w32tm /stripchart /computer:$myDomain /samples:5 /dataonly


# Join via PowerShell
Get-Host
$myDomain="dariens.tips"
Resolve-DnsName $myDomain
$myDomainCred=Get-Credential "<username>@$myDomain"
$ouPath="OU=Windows,OU=Domain Computers,DC=dariens,DC=tips"
Add-Computer -DomainCredential $myDomainCred -DomainName $myDomain -OUPath $ouPath -Restart


# Move Computer to OU
$CompToMove="DARTIPS9409"
Get-ADComputer $CompToMove | Move-ADObject -TargetPath "OU=Windows,OU=Domain Computers,DC=dariens,DC=tips"


# Prestage Computer Object
$newCompName="myNewComp"
$ouPath="OU=Windows,OU=Domain Computers,DC=dariens,DC=tips"
New-ADComputer -Name $newCompName -SAMAccountName $newCompName$ -Path $ouPath
Get-ADComputer -Identity $newCompName -Properties operatingsystem,operatingsystemversion

$compContnr="CN=Computers,DC=dariens,DC=tips"
Get-ADObject -Filter {ObjectClass -like "*"} -SearchBase $compContnr
