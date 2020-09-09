$ProjectsFolder = "~\projects"
$PowerShellFolder = "~\Documents\WindowsPowerShell"
$LocalIP = "$Env:LocalIP"
$UbuntuMachine = "$Env:UbuntuMachine"
$Chrome = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"


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

    VMs:
        ubuntu - 'Logon Ubuntu machine'

    Network:
        ab - 'Connect to work network'
        sz - 'Connect to internet'
        wifi - 'Show current wifi'

    Sites:
        azure - 'Azure Portal'
        github - 'Github'
        gitlab - 'Gitlab'
        mail - 'Mail'
        open [url] - 'Open url in browser'

    Search:
        baidu [keywords] - 'Search keywords using Baidu'
        bing [keywords] - 'Search keywords using Bing'
        can [word] - 'Can I Use'
        id - 'Work item'
        g [keywords] - 'Search keywords using Google'
        s [keywords] - 'Search keywords usering StackOverflow'

    Misc:
        commands - 'Show Commands'
        clipc - 'Clip Current Path'
        k - 'Kill process'
        ll - 'List items'
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
    Get-Eventlog -LogName Application -Newest $args[0] -Source *$args[1]* | Select-Object Index, EntryType, InstanceId, Message | format-list
}

function Start-ClearEventLogs () {
    & Clear-EventLog "Application"
    & Clear-EventLog "Security"
    & Clear-EventLog "System"
}

## VMs

function  Start-LogonUbuntu {
    ssh ubuntu@$UbuntuMachine
}


## Network
function Start-ConnectToWorkNetwork {
    $currentWifi = Start-ShowCurrentWifiNetwork
    if ($currentWifi -match "$Env:WorkNetworkName") {
        Write-Host "Already connected."
    }
    else {
        $result = netsh wlan connect name="$Env:WorkNetworkName"

        Write-Host "Connecting..." -NoNewline
        do {
            Write-Host "." -NoNewline
            Start-Sleep -Milliseconds 10

            $currentWifi = Start-ShowCurrentWifiNetwork
            $wifi = Get-NetAdapter -physical | Select-Object Name, Status, Speed | Where-Object Name -eq "Wi-Fi"
        } while ($currentWifi -notmatch "$Env:WorkNetworkName" -or $wifi.Status -ne 'Up')

        Write-Host ""
        Write-Host "Network switched to: $Env:WorkNetworkName"
        Get-NetAdapter -physical | Where-Object Name -eq  "Wi-Fi"
    }
}

function Start-ConnectToInternet {
    $currentWifi = Start-ShowCurrentWifiNetwork
    if ($currentWifi -match "$Env:InternetName") {
        Write-Host "Already connected."
    }
    else {
        $result = netsh wlan connect name="$Env:InternetName"

        Write-Host "Connecting..." -NoNewline

        do {
            Write-Host "." -NoNewline
            Start-Sleep -Milliseconds 10

            $currentWifi = Start-ShowCurrentWifiNetwork
            $wifi = Get-NetAdapter -physical | Select-Object Name, Status, Speed | Where-Object Name -eq "Wi-Fi"
        } while ($currentWifi -notmatch "$Env:InternetName" -or $wifi.Status -ne 'Up')

        Write-Host ""
        Write-Host "Network switched to: $Env:InternetName"
        Get-NetAdapter -physical | Where-Object Name -eq  "Wi-Fi"
    }
}

function Start-ShowCurrentWifiNetwork {
    return netsh wlan show interfaces | Select-String '\sSSID'
}

## Sites
function New-AzurePortal {
    $url = "https://portal.azure.com/"
    & $Chrome $url
    Write-Host "Azure Portal opened in Chrome."
}

function New-Github {
    $url = "https://github.com/"
    & $Chrome $url
    Write-Host "Github opened in Chrome."
}

function New-Gitlab {
    $url1 = $Env:GitlabPath
    & $Chrome $url1
    Write-Host "Gitlab opened in Chrome."
}

function New-Mail {
    $url = "https://outlook.office.com/mail/inbox"
    & $Chrome $url
    Write-Host "Mail opened in Chrome."
}

function New-OpenUrlInBrowser {
    $url = "http://$($args[0])"
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

function New-WorkItem {
    $url = $Env:JiraPath + $args[0]
    & $Chrome $url
    Write-Host "Workd item opened in Chrome."
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