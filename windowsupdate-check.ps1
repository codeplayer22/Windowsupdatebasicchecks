# Function to check if Windows updates are enabled
function Get-WindowsUpdateStatus {
    $WindowsUpdateService = Get-Service -Name wuauserv -ErrorAction SilentlyContinue

    if ($WindowsUpdateService -eq $null) {
        Write-Host "Windows Update service (wuauserv) is not running."
    } else {
        Write-Host "Windows Update service (wuauserv) is running."
    }

    $AutoUpdateSetting = Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name 'NoAutoUpdate' -ErrorAction SilentlyContinue

    if ($AutoUpdateSetting -eq $null -or $AutoUpdateSetting.NoAutoUpdate -eq 0) {
        Write-Host "Automatic Windows updates are enabled."
    } else {
        Write-Host "Automatic Windows updates are disabled."
    }
}


# Function to get the last installed KB or SSU update
function Get-LastInstalledKBorSSU {
    $UpdateHistory = Get-HotFix | Sort-Object -Property InstalledOn -Descending | Select-Object -First 1

    if ($UpdateHistory) {
        $KBNumber = $UpdateHistory.HotFixID
        $Description = $UpdateHistory.Description
        $InstalledOn = $UpdateHistory.InstalledOn
        Write-Host "Last installed KB or SSU update: $KBNumber - $Description (Installed on: $InstalledOn)"
    } else {
        Write-Host "No KB or SSU updates have been installed."
    }
}


# Function to check if Windows update components are working
function Get-WindowsUpdateComponentsStatus {
    $UpdateComponents = Get-Service -Name BITS, wuauserv, CryptSvc -ErrorAction SilentlyContinue

    if ($UpdateComponents -ne $null) {
        foreach ($Component in $UpdateComponents) {
            Write-Host "Windows Update component $($Component.Name) is $($Component.Status)."
        }
    } else {
        Write-Host "One or more Windows Update components are not running."
    }
}

# Function to check for pending reboots after installing updates
function Get-PendingRebootStatus {
    $PendingReboot = Get-WmiObject -Query "SELECT * FROM Win32_ComputerSystem" | Select-Object -ExpandProperty RebootPending

    if ($PendingReboot) {
        Write-Host "Pending reboot detected after installing updates."
    } else {
        Write-Host "No pending reboots found."
    }
}

# Main script execution
Write-Host "Checking Windows patching status..."
Write-Host "================================="

Get-WindowsUpdateStatus
Get-WindowsUpdateComponentsStatus
Get-LastInstalledKBorSSU
Get-PendingRebootStatus

Write-Host "================================="
Write-Host "Patch checking completed."

