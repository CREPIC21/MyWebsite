# Call the first PowerShell script
powershell.exe -ExecutionPolicy Unrestricted -File .\IIS_Config.ps1

# Call the second PowerShell script
powershell.exe -ExecutionPolicy Unrestricted -File .\deployScript.ps1