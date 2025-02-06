# Setzt die Execution Policy (nur falls nötig)
# Set-ExecutionPolicy unrestricted

# Parameter
$Eventlog = "Security"
$EventID = 4771

# E-Mail Parameter
$From = "from@some.domain"
$To = "to@some.domain"
$CC = "cc@some-domain"
$Subject = "Login Monitoring [BETA 1.1]"
$MailServer = "mail.some.domain"

# Log-Dateien
$LOGPATH = "C:\Skripting\Logs\Audit\"
$LOGTMP = "$LOGPATH\tmp.txt"
$LOG_NOMAIL = "$LOGPATH\nomail_login.txt"
$LOG_MAIL = "$LOGPATH\mail_login.txt"

# >>>>>>>> Query Eventlog <<<<<<<<
$Event = Get-WinEvent -FilterHashtable @{LogName=$Eventlog; ID=$EventID} -MaxEvents 1

if ($Event) {
    $Message = $Event.Message
    $TimeCreated = $Event.TimeCreated

    # Extrahiere relevante Informationen
    $Kontoname = if ($Message -match "Kontoname:\s+(\S+)") { $matches[1] } else { "Unbekannt" }
    $Clientadresse = if ($Message -match "Clientadresse:\s+(\S+)") { $matches[1] } else { "Unbekannt" }
    $Fehlercode = if ($Message -match "Fehlercode:\s+(\S+)") { $matches[1] } else { "Unbekannt" }

    # Fehlercode Lookup aus Datei
    $ErrorMsg = (Get-Content "C:\Skripting\error.txt" -Encoding UTF8) | Where-Object { $_ -match "$Fehlercode" }
    if (-not $ErrorMsg) { $ErrorMsg = "Unbekannter Fehlercode: $Fehlercode" }

    # HTML-Mail-Body
    $Output = @"
    <b><h1>Fehlerhafter Login:</h1></b>
    <p><b>Kontoname:</b> $Kontoname</p>
    <p><b>Clientadresse:</b> $Clientadresse</p>
    <p><b>Zeitpunkt:</b> $TimeCreated</p>
    <p><b>Fehlercode:</b> $ErrorMsg</p>
"@

    # >>>>>>>> Send Mail-Alert <<<<<<<<
    if ($Kontoname -like '*RDS-Broker$*') {
        # Falls der Benutzer "RDS-Broker" ist, nur ins Log schreiben
        $Output | Set-Content -Path $LOG_NOMAIL -Encoding UTF8
    } else {
        # Andernfalls eine E-Mail versenden
        Send-MailMessage -Cc $CC -From $From -To $To -Subject $Subject -SmtpServer $MailServer -BodyAsHtml $Output
        $Output | Set-Content -Path $LOG_MAIL -Encoding UTF8
    }
}
