import-module servermanager
add-windowsfeature web-server -includeallsubfeature
add-windowsfeature Web-Asp-Net45
add-windowsfeature NET-Framework-Features
New-Item -Path "C:\inetpub\wwwroot\" -Name "images" -ItemType "directory"
Copy-Item -Path "C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\1.10.15\Downloads\0\images_01" -Destination "C:\inetpub\wwwroot\images\image_01.jpg" -Force
Copy-Item -Path "C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\1.10.15\Downloads\0\images_02" -Destination "C:\inetpub\wwwroot\images\image_02.jpg" -Force
Set-Content -Path "C:\inetpub\wwwroot\images\Default.html" -Value "This is the images server"
$folderPath = "C:\inetpub\wwwroot\images"
$items = Get-ChildItem -Path $folderPath
foreach ($item in $items) {
    $acl = Get-Acl $item.FullName
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "Read", "Allow")
    $acl.SetAccessRule($rule)
    Set-Acl -Path $item.FullName -AclObject $acl
}