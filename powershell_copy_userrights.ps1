#Which user will be copied
[string]$USERFROM = ""

#Copy to Users, can be seperated by comma
[string]$USERTO = ""


### Do the Action.
Get-ADUser -Identity $USERFROM -Properties memberof | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $USERTO -PassThru | Select-Object -Property SamAccountName
