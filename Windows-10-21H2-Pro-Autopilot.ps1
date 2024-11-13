Write-Host  -ForegroundColor Cyan 'Windows 11 24H2 Pro Autopilot'
#================================================
#   [PreOS] Update Module
#================================================
if ((Get-MyComputerModel) -match 'Virtual') {
    Write-Host  -ForegroundColor Green "Setting Display Resolution to 1600x"
    Set-DisRes 1600
}

#Write-Host -ForegroundColor Green "Updating OSD PowerShell Module"
#Install-Module OSD -Force

#Write-Host  -ForegroundColor Green "Importing OSD PowerShell Module"
#Import-Module OSD -Force   

#=======================================================================
#   [OS] Params and Start-OSDCloud
#=======================================================================
$Params = @{
    OSName = "Windows 11 24H2 x64"
    OSLicense = "Retail"
    OSEdition = "Pro"
    OSLanguage = "sv-se"
    ZTI = $true
}
Start-OSDCloud @Params

#================================================
#  [PostOS] OOBEDeploy Configuration
#================================================
Write-Host -ForegroundColor Green "Create C:\ProgramData\OSDeploy\OSDeploy.OOBEDeploy.json"
$OOBEDeployJson = @'
{
    "Autopilot":  {
                      "IsPresent":  false
                  },
    "AddNetFX3":  {
                      "IsPresent":  true
                    },                     
    "UpdateDrivers":  {
                          "IsPresent":  true
                      },
    "UpdateWindows":  {
                          "IsPresent":  true
                      }
}
'@
If (!(Test-Path "C:\ProgramData\OSDeploy")) {
    New-Item "C:\ProgramData\OSDeploy" -ItemType Directory -Force | Out-Null
}
$OOBEDeployJson | Out-File -FilePath "C:\ProgramData\OSDeploy\OSDeploy.OOBEDeploy.json" -Encoding ascii -Force

#================================================
#  [PostOS] AutopilotOOBE Configuration Staging
#================================================
Write-Host -ForegroundColor Green "Create C:\ProgramData\OSDeploy\OSDeploy.AutopilotOOBE.json"
$AutopilotOOBEJson = @'
{
    "Assign":  {
                   "IsPresent":  true
               },
    "GroupTag":  "En till en - GVF",
    "GroupTagOptions":  [  
   "En till en - GVF Teknik",
   "En till en - KTC",
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
   "En till flera - Sundsta-Alvkullegymnasiet KIOSK"
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
#	UnattendXml
#=================================================
$UnattendXml = @'
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="specialize">
        <component name="Microsoft-Windows-Deployment" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <RunSynchronous>
                <RunSynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Description>OSDCloud Specialize</Description>
                    <Path>Powershell -ExecutionPolicy Bypass -Command Invoke-OSDSpecialize -Verbose</Path>
                </RunSynchronousCommand>
            </RunSynchronous>
        </component>
    </settings>
</unattend>
'@

#=================================================
#	Directories
#=================================================
if (-NOT (Test-Path 'C:\Windows\Panther')) {
    New-Item -Path 'C:\Windows\Panther'-ItemType Directory -Force -ErrorAction Stop | Out-Null
}

#=================================================
#	Panther Unattend
#=================================================
$Panther = 'C:\Windows\Panther'
$UnattendPath = "$Panther\Unattend.xml"
Write-Verbose -Verbose "Setting $UnattendPath"
$UnattendXml | Out-File -FilePath $UnattendPath -Encoding utf8 -Width 2000 -Force

#=================================================
#	Copy PSModule
#=================================================
Write-Verbose -Verbose "Copy-PSModuleToFolder -Name OSD to C:\Program Files\WindowsPowerShell\Modules"
Copy-PSModuleToFolder -Name OSD -Destination 'C:\Program Files\WindowsPowerShell\Modules'

#=================================================
#	Use-WindowsUnattend
#=================================================
Write-Verbose -Verbose "Use-WindowsUnattend -Path 'C:\' -UnattendPath $UnattendPath"
Use-WindowsUnattend -Path 'C:\' -UnattendPath $UnattendPath -Verbose
#Notepad $UnattendPath
#=================================================

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
#Start /Wait PowerShell -NoL -C Start-OOBEDeploy
#Start /Wait PowerShell -NoL -C Restart-Computer -Force
'@
$AutopilotCMD | Out-File -FilePath 'C:\Windows\System32\Karlstad.cmd' -Encoding ascii -Force

#================================================
#  [PostOS] SetupComplete CMD Command Line
#================================================
Write-Host -ForegroundColor Green "Create C:\Windows\Setup\Scripts\SetupComplete.cmd"
$SetupCompleteCMD = @'
RD C:\OSDCloud\OS /S /Q
RD C:\Drivers /S /Q
'@
$SetupCompleteCMD | Out-File -FilePath 'C:\Windows\Setup\Scripts\SetupComplete.cmd' -Encoding ascii -Force

#=======================================================================
#   Restart-Computer
#=======================================================================
Write-Host  -ForegroundColor Green "Restarting in 5 seconds!"
Start-Sleep -Seconds 5
wpeutil reboot
