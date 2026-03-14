winget uninstall "windows web experience pack"
Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage
winget install --id Microsoft.PowerToys --source winget
winget install --id Google.JapaneseIME

winget install WinFsp.WinFsp
winget install SSHFS-Win.SSHFS-Win

# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts\411
