$ProjectsFolder = "D:\Projects"
$OneboxFolder = "D:\Onebox"
$DefaultBookmarksPath = "~/AppData/Local/Google/Chrome/User Data/Default/Bookmarks"
$Profile2BookmarksPath = "~/AppData/Local/Google/Chrome/User Data/Profile 2/"
$HuaweiBrowserDefaultBookmarksPath = "~/AppData/Local/Huawei/HuaweiBrowser/User Data/Default/"
$PowerShellFolder = "~\Documents\WindowsPowerShell"
$Chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$W3_TERMINOLOGY_URL = "https://3ms.huawei.com/terminology/#/main/termSearch?searchValue="
$W3_SEARCH_URL = "https://w3.huawei.com/unisearch/index.html?keyword=%E6%B2%88%E8%85%BE%2000813569#lang=zh&newKeyword="


function Start-Up {
    Write-Host "
    Good to see you!

    Folders:
        p - 'Projects folder'
        psf - 'My PowerShell Folder'

    Logs:
        ev - 'Open Event Viewer'
        log - 'Logging Events'
        clearlog - 'Clear Event Logs'

    Network:
        workwifi - 'Connect to work network'
        wifi - 'Show current wifi'
        ee - 'Enable Ethernet'
        de - 'Disable Ethernet'

    Sites:
        w3 - 'W3 Portal'
        codehub - 'CodeHub'
        github - 'Github'
        open [url] - 'Open url in browser'
        t [terminology] - 'Open terminology in browser'
        w [keyword] - 'Open w3 search in browser'

    Search:
        b [keywords] - 'Search keywords using Baidu'
        bing [keywords] - 'Search keywords using Bing'
        can [word] - 'Can I Use'
        di [word] - 'Youdao Dict'
        g [keywords] - 'Search keywords using Google'
        s [keywords] - 'Search keywords usering StackOverflow'

    Misc:
        ca - 'Cat file content in Unicode format'
        sbo - 'Sync default bookmarks to Onebox'
        sb2 - 'Sync default bookmarks to Profile 2'
        sbh - 'Sync default bookmarks to Huawei Browser'
        sboa - 'Sync Onebox bookmarks to All'
        d - 'Download file'
        dm - 'Download multiple files'
        commands - 'Show Commands'
        clipc - 'Clip Current Path'
        k - 'Kill process'
        ll - 'List items'
        battery - 'Battery Report'
        hibernate - 'Hibernate computer'
        rst - 'Restart computer'
        stc - 'Shutdown computer'
    "
}

Start-Up

## Folders
function Enter-ProjectsFolder {
    Set-Location $ProjectsFolder
}

function Enter-PowerShellFolder {
    Set-Location $PowerShellFolder
}


## Logs
function Start-EventViewer {
    & 'eventvwr'
}

function Start-LoggingEvents {
    Get-Eventlog -LogName Application -Newest $args[0] | Select-Object Index, EntryType, InstanceId, Message | format-list
}

function Start-ClearEventLogs () {
    & Clear-EventLog "Application"
    & Clear-EventLog "Security"
    & Clear-EventLog "System"
}


## Network
function Start-ConnectToWorkNetwork {
    $currentWifi = Start-ShowCurrentWifiNetwork
    $tryCount = 0;
    if ($currentWifi -match "$Env:WorkNetworkName") {
        Write-Host "Already connected."
    }
    else {
        $result = netsh wlan connect name="$Env:WorkNetworkName"

        Write-Host "Connecting..." -NoNewline
        do {
            Write-Host "." -NoNewline
            Start-Sleep -Milliseconds 10
            $tryCount = $tryCount + 1
            $currentWifi = Start-ShowCurrentWifiNetwork
            $wifi = Get-NetAdapter -physical | Select-Object Name, Status, Speed | Where-Object Name -eq "Wi-Fi"
        } while ($currentWifi -notmatch "$Env:WorkNetworkName" -or $wifi.Status -ne 'Up' -and $tryCount -lt 50)

        if ($currentWifi -match "$Env:WorkNetworkName") {
            Write-Host "`nNetwork switched to: $Env:WorkNetworkName"
            Get-NetAdapter -physical | Where-Object Name -eq  "Wi-Fi"
        }
        else {
            Write-Host "`nFailed to connect: $Env:WorkNetworkName"
        }
    }
}

function Start-ShowCurrentWifiNetwork {
    return netsh wlan show interfaces | Select-String '\sSSID'
}

function Start-EnableEthernet {
    Enable-NetAdapter -Name Ethernet -Confirm:$False
    Write-Host "Ethernet enabled"
}

function Start-DisableEthernet {
    Disable-NetAdapter -Name Ethernet -Confirm:$False
    Write-Host "Ethernet disabled"
}


## Sites
function New-W3Portal {
    $url = "http://w3.huawei.com/"
    & $Chrome $url
    Write-Host "W3 Portal opened in Chrome."
}

function New-Codehub {
    $url = "https://codehub-g.huawei.com/workspace/projects"
    & $Chrome $url
    Write-Host "CodeHub opened in Chrome."
}

function New-Github {
    $url = "https://github.com/"
    & $Chrome $url
    Write-Host "Github opened in Chrome."
}

function New-OpenUrlInBrowser {
    $url = "http://$($args[0])"
    Write-Host "Opened $url in browser"
    & $Chrome $url
}

function New-OpenTerminologyInBrowser {
    $url = $W3_TERMINOLOGY_URL + [string]$args[0]
    Write-Host "Opened $url in browser"
    & $Chrome $url
}

function New-OpenW3SearchInBrowser {
    $url = $W3_SEARCH_URL + [string]$args[0]
    if ($args.Length -gt 1) {
        $url = $url + '%20' + [string]$args[1]
    }
    Write-Host "Opened $url in browser"
    & $Chrome $url
}


## Search
function New-Baidu {
    Write-Host "Searched keywords using Baidu."
    $url = "https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=0&rsv_idx=1&tn=baidu&wd=$args"
    & $Chrome $url
}

function New-Bing {
    Write-Host "Searched keywords using Bing."
    $url = "http://cn.bing.com/search?q=$args"
    & $Chrome $url
}

function New-CanIUse {
    Write-Host "Can I use $($args[0]) ?"
    $url = "http://caniuse.com/#search=$($args[0])"
    & $Chrome $url
}

function New-YoudaoDict {
    Write-Host "Youdao Dict $($args[0]) ?"
    $url = "https://dict.youdao.com/result?word=$($args[0])&lang=en"
    & $Chrome $url
}

function New-Google {
    Write-Host "Searched keywords using Google."
    $url = "http://www.google.com/search?q=$args"
    & $Chrome $url
}

function New-StackOverflow {
    $url = "https://stackoverflow.com/search?q=$args"
    & $Chrome $url
    Write-Host "StackOverflow opened in Chrome."
}


## Misc
function Start-CatFileContent {
    Get-Content $args[0] -Encoding UTF8
}

function Start-SyncDefaultBookmarksToOnebox {
    cp $DefaultBookmarksPath $OneboxFolder
    Write-Host "$DefaultBookmarksPath has been copied to $OneboxFolder"
}

function Start-SyncDefaultBookmarksToProfile2 {
    ## ii $Profile2BookmarksPath
    cp $DefaultBookmarksPath $Profile2BookmarksPath
    Write-Host "$DefaultBookmarksPath has been copied to $Profile2BookmarksPath"
}

function Start-SyncDefaultBookmarksToHuaweiBrowserDefault {
    cp $DefaultBookmarksPath $HuaweiBrowserDefaultBookmarksPath
    Write-Host "$DefaultBookmarksPath has been copied to $HuaweiBrowserDefaultBookmarksPath"
}

function Start-SyncOneboxBookmarksAllBrowsers {
    cp "$OneboxFolder/Bookmarks" $DefaultBookmarksPath
    cp "$OneboxFolder/Bookmarks" $Profile2BookmarksPath
    cp "$OneboxFolder/Bookmarks" $HuaweiBrowserDefaultBookmarksPath
    Write-Host "$OneboxFolder/Bookmarks has been copied to " $DefaultBookmarksPath
    Write-Host "$OneboxFolder/Bookmarks has been copied to " $Profile2BookmarksPath
    Write-Host "$OneboxFolder/Bookmarks has been copied to " $HuaweiBrowserDefaultBookmarksPath
}

function Start-DownloadFile {
    Start-BitsTransfer $args[0]
}

function Start-DownloadMultipleFiles {
    Import-CSV $args[0] | Start-BitsTransfer
}

function Start-ShowCommands {
    Start-Up
}

function Start-ClipCurrentPath {
    $pwd.Path | clip
}

function Start-KillProcess () {
    & Stop-Process -Name $args[0]
}

function Start-ListItems {
    if ($args[0]) {
        & Get-ChildItem $args[0]
    }
    else {
        & Get-ChildItem
    }
}

function Start-BatteryReport {
    Set-Location $ProjectsFolder
    & powercfg /batteryreport
    $url = "$($ProjectsFolder)\battery-report.html"
    & $Chrome $url
}

function Start-HibernateComputer {
    & shutdown /h
}

function Start-RestartComputer {
    if ($args[0]) {
        & shutdown /r /t $args[0]
    }
    else {
        & shutdown /r /t 0
    }
}

function Start-ShutdownComputer {
    if ($args[0]) {
        & shutdown /s /t $args[0]
    }
    else {
        & shutdown /s /t 0
    }
}