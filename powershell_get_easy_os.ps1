$OSVersion = (get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
function test-os {
If($OSVersion -eq "Windows Server 2008 R2 Standard")
{
Write-Host "Hooray It's Server 2K8 r2!"
}
ElseIf($OSVersion -eq "Windows 10 Pro")
{
Write-Host "Okay, Windows 10 Pro is cool, too!"

}
ElseIf($OSVersion -eq "Windows 8.1 Prof")
{
Write-Host "Okay, Windows 8.1 is maybe cool, too!"

}
ElseIf($OSVersion -eq "Windows 8 Prof")
{
Write-Host "Okay, Windows 8 is sadly uncool"

}
ElseIf($OSVersion -eq "Windows 7 Prof")
{
Write-Host "Okay, Windows 7 is cool, too!"

}
ElseIf($OSVersion -eq "Windows Vista")
{
Write-Host "What have I done with my life?!"

}
ElseIf($OSVersion -eq "Windows Millennium Edition")
{
Write-Host "Go away, operating system.  You are drunk."

}
}
clear
write-host ""
test-os
write-host ""
