# Alle mit BitLocker verschlüsselten Volumes abrufen
# Ausgabe bleibt aus, wenn nichts zu tun ist... ES GIBT KEINE RÜCKMELDUNG DANN... OK?! :D
$bitlockerVolumes = Get-BitLockerVolume | Where-Object {$_.ProtectionStatus -eq 'On'}

# Durch jedes verschlüsselte Volume iterieren
foreach ($volume in $bitlockerVolumes) {
    $mountPoint = $volume.MountPoint
    Write-Output "Verarbeite Laufwerk: $mountPoint"

    # Alle KeyProtector-IDs für das Volume abrufen
    foreach ($protector in $volume.KeyProtector) {
        # Sicherstellen, dass es sich um einen Wiederherstellungskennwortschutz handelt
        if ($protector.KeyProtectorType -eq 'RecoveryPassword') {
            $keyProtectorId = $protector.KeyProtectorId
            Write-Output "Sichere KeyProtectorId: $keyProtectorId für Laufwerk $mountPoint"

            # Wiederherstellungsschlüssel in Active Directory sichern
            Backup-BitLockerKeyProtector -MountPoint $mountPoint -KeyProtectorId $keyProtectorId
        }
    }
}
