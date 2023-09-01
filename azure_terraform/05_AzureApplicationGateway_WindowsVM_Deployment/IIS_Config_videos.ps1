import-module servermanager
add-windowsfeature web-server -includeallsubfeature
add-windowsfeature Web-Asp-Net45
add-windowsfeature NET-Framework-Features
New-Item -Path "C:\inetpub\wwwroot\" -Name "videos" -ItemType "directory"
Copy-Item -Path "C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\1.10.15\Downloads\0\videos_01" -Destination "C:\inetpub\wwwroot\videos\video_01.MOV" -Force
Copy-Item -Path "C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\1.10.15\Downloads\0\videos_02" -Destination "C:\inetpub\wwwroot\videos\video_02.MOV" -Force
Set-Content -Path "C:\inetpub\wwwroot\videos\Default.html" -Value "This is the videos server"
$folderPath = "C:\inetpub\wwwroot\videos"
$items = Get-ChildItem -Path $folderPath
foreach ($item in $items) {
    $acl = Get-Acl $item.FullName
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "Read", "Allow")
    $acl.SetAccessRule($rule)
    Set-Acl -Path $item.FullName -AclObject $acl
}