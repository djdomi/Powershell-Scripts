$ErrorActionPreference = "Stop"
function unlock-fast {
    $ErrorActionPreference = "Stop"
    $WhatsTheUser = Write-Host Using $args[0] as user

        do 
            {  
                $ErrorActionPreference = "Stop" 
                Unlock-ADAccount -ErrorAction Stop $args[0]
                Write-Host unlocking $args[0]
                sleep 1
               
            } while ($true)
    }


function unlock-fast-ask {
$ErrorActionPreference = "Stop"
    $WhatsTheUser = Read-Host -Prompt 'Enter Username which should be unlocked'

        do 
            { 
                Unlock-ADAccount -ErrorAction Stop $WhatsTheUser
                Write-Host "unlocking $WhatsTheUser"
                sleep 1
                        
            } while ($true)
    }    
           
