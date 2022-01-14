function copyuserrights-fast {
    $ErrorActionPreference = "Stop"
    $USERFROM1 = Write-Host Using $args[0] as user from and $args[1] to
    $USERTO1 = Write-Host Using $args[1] Remind to user comma without space to use multiple users
    $USERFROM = $args[0]
    $USERTO = $args[1]

Get-ADUser -Identity $USERFROM -Properties memberof | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $USERTO -PassThru | Select-Object -Property SamAccountName
    }


function copyuserrights-fast-ask {
    $ErrorActionPreference = "Stop"
        $USERFROM = Read-Host -Prompt 'Enter Username which should be copied from a single user'
        $USERTO = Read-Host -Prompt 'Enter Username which should be copied to, it is possible to use user1,user2,user3'
    #
Get-ADUser -Identity $USERFROM -Properties memberof | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $USERTO -PassThru | Select-Object -Property SamAccountName
    }    
           



function copyuserright-fast-native {
#Which user will be copied
[string]$USERFROM = ""

#Copy to Users, can be seperated by comma
[string]$USERTO = ""


### Do the Action.
Get-ADUser -Identity $USERFROM -Properties memberof | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $USERTO -PassThru | Select-Object -Property SamAccountName
}
