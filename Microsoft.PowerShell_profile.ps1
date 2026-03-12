Import-Module MyModule

## Folders
New-Alias -name p -value Enter-ProjectsFolder
New-Alias -name psf -value Enter-PowerShellFolder

## Logs
New-Alias -name ev -value Start-EventViewer
New-Alias -name log -value Start-LoggingEvents
New-Alias -name clearlog -value Start-ClearEventLogs

## Network
New-Alias -name workwifi -value Start-ConnectToWorkNetwork
New-Alias -name wifi -value Start-ShowCurrentWifiNetwork
New-Alias -name ee -value Start-EnableEthernet
New-Alias -name de -value Start-DisableEthernet

## Sites
New-Alias -name w3 -value New-W3Portal
New-Alias -name codehub -value New-CodeHub
New-Alias -name github -value New-Github
New-Alias -name open -value New-OpenUrlInBrowser
New-Alias -name t -value New-OpenTerminologyInBrowser
New-Alias -name w -value New-OpenW3SearchInBrowser

## Search
New-Alias -name b -value New-Baidu
New-Alias -name bing -value New-Bing
New-Alias -name can -value New-CanIUse
New-Alias -name di -value New-YoudaoDict
New-Alias -name g -value New-Google
New-Alias -name s -value New-StackOverflow

## Sync files
New-Alias -name sbo -value Start-SyncDefaultBookmarksToOnebox
New-Alias -name dbo -value Start-DeleteBookmarksInOnebox
New-Alias -name sb2 -value Start-SyncDefaultBookmarksToProfile2
New-Alias -name db2 -value Start-DeleteBookmarksInProfile2
New-Alias -name sbh -value Start-SyncDefaultBookmarksToHuaweiBrowserDefault
New-Alias -name dbh -value Start-DeleteBookmarksInHuaweiBrowserDefault
New-Alias -name sboa -value Start-SyncOneboxBookmarksAllBrowsers

## Misc
New-Alias -name ca -value Start-CatFileContent
New-Alias -name d -value Start-DownloadFile
New-Alias -name dm -value Start-DownloadMultipleFiles
New-Alias -name commands -value Start-ShowCommands
New-Alias -name clipc -value Start-ClipCurrentPath
New-Alias -name k -value Start-KillProcess
New-Alias -name ll -value Start-ListItems
New-Alias -name battery -value Start-BatteryReport
New-Alias -name hibernate -value Start-HibernateComputer
New-Alias -name rst -value Start-RestartComputer
New-Alias -name stc -value Start-ShutdownComputer