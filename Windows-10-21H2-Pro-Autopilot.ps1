Write-Host  -ForegroundColor Cyan 'Windows 11 26H2 Pro Autopilot'
#================================================
#   [PreOS] Update Module
#================================================
if ((Get-MyComputerModel) -match 'Virtual') {
    Write-Host  -ForegroundColor Green "Setting Display Resolution to 1600x"
    Set-DisRes 1600
}

#================================================
#   [Stage 0] Allow Dism to load, then rerun in a fresh PowerShell process
#================================================
$ScriptUrl = 'https://raw.githubusercontent.com/ddhn07/foitintune/refs/heads/main/Windows-10-21H2-Pro-Autopilot.ps1'

if (-not $env:OSD_RELAUNCHED) {
    $cfg = 'X:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe.config'
    [xml]$xml = if (Test-Path $cfg) { Get-Content $cfg -Raw } else { '<configuration/>' }
    $root    = $xml.DocumentElement
    $runtime = $root.SelectSingleNode('runtime')
    if (-not $runtime) { $runtime = $root.AppendChild($xml.CreateElement('runtime')) }
    $node = $runtime.SelectSingleNode('loadFromRemoteSources')
    if (-not $node) { $node = $runtime.AppendChild($xml.CreateElement('loadFromRemoteSources')) }
    $node.SetAttribute('enabled','true')
    $xml.Save($cfg)

    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
    $local = 'X:\OSDCloudStage.ps1'
    (New-Object System.Net.WebClient).DownloadFile($ScriptUrl, $local)

    $env:OSD_RELAUNCHED = '1'    # inherited by the child; prevents a relaunch loop
    Start-Process powershell.exe -Wait -NoNewWindow -ArgumentList '-NoL','-ExecutionPolicy','Bypass','-File',$local
    return
}

#=======================================================================
#   [OS] Global variables, params and Start-OSDCloud
#=======================================================================

$Global:MyOSDCloud = [ordered]@{
    RecoveryPartition = [bool]$true
    WindowsUpdate = [bool]$true
    WindowsUpdateDrivers = [bool]$true
    WindowsDefenderUpdate = [bool]$true
}

$Params = @{
    OSName = "Windows 11 26H2 x64"
    OSActivation = "Retail"
    OSEdition = "Pro"
    OSLanguage = "sv-se"
    ZTI = $true
    Firmware = $true
}

Start-OSDCloud @Params

#================================================
#  [PostOS] AutopilotOOBE Configuration Staging
#================================================
Write-Host -ForegroundColor Green "Create C:\ProgramData\OSDeploy\OSDeploy.AutopilotOOBE.json"
$AutopilotOOBEJson = @'
{
    "Assign":  {
                   "IsPresent":  true
               },
    "GroupTag":  "Write your groupTag or select from list",
    "GroupTagOptions":  [
   "En till en - CSU",
   "En till en - Fredricelundsskolan",
   "En till flera - Fredricelundsskolan",
   "En till en - Frodingskolan",
   "En till flera - Frodingskolan",
   "En till en - Farjestadsskolan",
   "En till flera - Farjestadsskolan",
   "En till en - Hagaborgsskolan",
   "En till flera - Hagaborgsskolan",
   "En till en - Herrhagsskolan",
   "En till flera - Herrhagsskolan",
   "En till en - Hultsbergsskolan",
   "En till flera - Hultsbergsskolan",
   "En till en - Ilandaskolan",
   "En till flera - Ilandaskolan",
   "En till en - Kronoparksskolan",
   "En till flera - Kronoparksskolan",
   "En till en - Kroppkarrsskolan",
   "En till flera - Kroppkarrsskolan",
   "En till en - Kvarnbergsskolan",
   "En till flera - Kvarnbergsskolan",
   "En till en - Mariebergsskolan",
   "En till flera - Mariebergsskolan",
   "En till en - Nobelgymnasiet",
   "En till flera - Nobelgymnasiet",
   "En till flera - Nobelgymnasiet KIOSK",
   "En till en - Norrstrandsskolan",
   "En till flera - Norrstrandsskolan",
   "En till en - Nyeds skola",
   "En till flera - Nyeds skola",
   "En till en - Orrholmsskolan",
   "En till flera - Orrholmsskolan",
   "En till en - Rudsskolan",
   "En till flera - Rudsskolan",
   "En till en - Ratorpsskolan",
   "En till flera - Ratorpsskolan",
   "En till en - Skattkarrsskolan",
   "En till flera - Skattkarrsskolan",
   "En till en - Skareskolan",
   "En till flera - Skareskolan",
   "En till en - Stockfallets skola",
   "En till flera - Stockfallets skola",
   "En till en - Stodeneskolan",
   "En till flera - Stodeneskolan",
   "En till en - Sodra Ratorps skola",
   "En till flera - Sodra Ratorps skola",
   "En till en - Tingvallagymnasiet",
   "En till flera - Tingvallagymnasiet",
   "En till flera - Tingvallagymnasiet KIOSK",
   "En till en - Tuggeliteskolan",
   "En till flera - Tuggeliteskolan",
   "En till en - Vallargardets skola",
   "En till flera - Vallargardets skola",
   "En till en - Valbergsskolan",
   "En till flera - Valbergsskolan",
   "En till en - Vase skola",
   "En till flera - Vase skola",
   "En till en - Vasterstrandsskolan",
   "En till flera - Vasterstrandsskolan",
   "En till en - Sundsta-Alvkullegymnasiet",
   "En till en - Sundsta-Alvkullegymnasiet KTC",
   "En till en - Sundsta-Alvkullegymnasiet TEKNIK",
   "En till flera - Sundsta-Alvkullegymnasiet",
   "En till flera - Sundsta-Alvkullegymnasiet KIOSK",
   "En till flera - Sundsta-Alvkullegymnasiet KTC"
                    ],
    "Hidden":  [
                   "AddToGroup",
                   "AssignedComputerName",
                   "AssignedUser",
                   "PostAction",
                   "Assign",
                   "Run",
                   "Docs"
               ],
    "PostAction":  "Quit",
    "Title":  "Autopilot OOBE Deploy"
}
'@
If (!(Test-Path "C:\ProgramData\OSDeploy")) {
    New-Item "C:\ProgramData\OSDeploy" -ItemType Directory -Force | Out-Null
}
$AutopilotOOBEJson | Out-File -FilePath "C:\ProgramData\OSDeploy\OSDeploy.AutopilotOOBE.json" -Encoding ascii -Force

#=================================================
#	Copy PSModule
#=================================================
Write-Verbose -Verbose "Copy-PSModuleToFolder -Name OSD to C:\Program Files\WindowsPowerShell\Modules"
Copy-PSModuleToFolder -Name OSD -Destination 'C:\Program Files\WindowsPowerShell\Modules'

#================================================
#  [PostOS] AutopilotOOBE CMD Command Line
#================================================
Write-Host -ForegroundColor Green "Create C:\Windows\System32\Karlstad.cmd"
$AutopilotCMD = @'
PowerShell -NoL -Com Set-ExecutionPolicy RemoteSigned -Force
Set Path = %PATH%;C:\Program Files\WindowsPowerShell\Scripts
Start /Wait PowerShell -NoL -C Install-Module AutopilotOOBE -Force -Verbose
Start /Wait PowerShell -NoL -C Install-Module OSD -Force -Verbose
Start /Wait PowerShell -NoL -C Start-AutopilotOOBE
Start /Wait PowerShell -NoL -C Start-OOBEDeploy
REM Start /Wait PowerShell -NoL -C Restart-Computer -Force
'@
$AutopilotCMD | Out-File -FilePath 'C:\Windows\System32\Karlstad.cmd' -Encoding ascii -Force

#================================================
#  [PostOS] APPEND SetupComplete CMD Command Line
#================================================
Write-Host -ForegroundColor Green "Append C:\Windows\Setup\Scripts\SetupComplete.cmd"
$CleanupLines = @'

RD C:\OSDCloud\OS /S /Q
RD C:\Drivers /S /Q
'@
Add-Content -Path 'C:\Windows\Setup\Scripts\SetupComplete.cmd' -Value $CleanupLines -Encoding ascii

#=======================================================================
#   Restart-Computer
#=======================================================================
Write-Host  -ForegroundColor Green "Restarting in 5 seconds!"
Start-Sleep -Seconds 5
wpeutil reboot

