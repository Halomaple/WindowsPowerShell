Import-Module MyModule

## Folders
New-Alias -name p -value Enter-ProjectsFolder -description "Projects Folder" -option ReadOnly
New-Alias -name psf -value Enter-PowerShellFolder -description "My PowerShell Folder" -option ReadOnly

## Logs
New-Alias -name ev -value Start-EventViewer -description "Open Event Viewer" -option ReadOnly
New-Alias -name log -value Start-LoggingEvents -description "Logging Events" -option ReadOnly
New-Alias -name clearlog -value Start-ClearEventLogs -description "Clear Event Logs" -option ReadOnly

## Network
New-Alias -name workwifi -value Start-ConnectToWorkNetwork -description "Work network wifi" -option ReadOnly
New-Alias -name wifi -value Start-ShowCurrentWifiNetwork -description "Show current wifi" -option ReadOnly
New-Alias -name ee -value Start-EnableEthernet -description "Enable Ethernet" -option ReadOnly
New-Alias -name de -value Start-DisableEthernet -description "Disable Ethernet" -option ReadOnly

## Sites
New-Alias -name w3 -value New-W3Portal -description "W3 Portal" -option ReadOnly
New-Alias -name codehub -value New-CodeHub -description "CodeHub" -option ReadOnly
New-Alias -name github -value New-Github -description "Github" -option ReadOnly
New-Alias -name open -value New-OpenUrlInBrowser -description "Open url in browser" -option ReadOnly
New-Alias -name t -value New-OpenTerminologyInBrowser -description "Open terminology in browser" -option ReadOnly
New-Alias -name w -value New-OpenW3SearchInBrowser -description "Open w3 search in browser" -option ReadOnly

## Search
New-Alias -name b -value New-Baidu -description "Baidu" -option ReadOnly
New-Alias -name bing -value New-Bing -description "Bing" -option ReadOnly
New-Alias -name can -value New-CanIUse -description "Baidu" -option ReadOnly
New-Alias -name di -value New-YoudaoDict -description "Youdao Dict" -option ReadOnly
New-Alias -name g -value New-Google -description "Google" -option ReadOnly
New-Alias -name s -value New-StackOverflow -description "StackOverflow" -option ReadOnly

## Misc
New-Alias -name ca -value Start-CatFileContent -description "Cat file content" -option ReadOnly
New-Alias -name sbo -value Start-SyncDefaultBookmarksToOnebox -description "Sync default bookmarks to Onebox" -option ReadOnly
New-Alias -name sb2 -value Start-SyncDefaultBookmarksToProfile2 -description "Sync default bookmarks to Profile 2" -option ReadOnly
New-Alias -name sbh -value Start-SyncDefaultBookmarksToHuaweiBrowserDefault -description "Sync default bookmarks to Huawei Browser" -option ReadOnly
New-Alias -name sboa -value Start-SyncOneboxBookmarksAllBrowsers -description "Sync Onebox bookmarks to All" -option ReadOnly
New-Alias -name d -value Start-DownloadFile -description "Download file" -option ReadOnly
New-Alias -name dm -value Start-DownloadMultipleFiles -description "Download multiple files" -option ReadOnly
New-Alias -name commands -value Start-ShowCommands -description "Show Commands" -option ReadOnly
New-Alias -name clipc -value Start-ClipCurrentPath -description "Clip Current Path" -option ReadOnly
New-Alias -name k -value Start-KillProcess -description "Kill process" -option ReadOnly
New-Alias -name ll -value Start-ListItems -description "List items" -option ReadOnly
New-Alias -name battery -value Start-BatteryReport -description "Battery Report" -option ReadOnly
New-Alias -name hibernate -value Start-HibernateComputer -description "Hibernate computer" -option ReadOnly
New-Alias -name rst -value Start-RestartComputer -description "Restart computer" -option ReadOnly
New-Alias -name stc -value Start-ShutdownComputer -description "Shutdown computer" -option ReadOnly