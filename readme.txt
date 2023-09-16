This is a basic script to check the windows update services if they are running.
Also, its gives the last installed update on the server.
Checks if reboot is pending on the server or not.

The script output as follows :

Checking Windows patching status...
=================================
Windows Update service (wuauserv) is running.
Automatic Windows updates are enabled.
Windows Update component BITS is Stopped.
Windows Update component CryptSvc is Running.
Windows Update component wuauserv is Running.
Last installed KB or SSU update: KB5029244 - Security Update (Installed on: 08/19/2023 00:00:00)
Select-Object : Property "RebootPending" cannot be found.
At E:\Scripts\windowsupdatescript\windowsupdate-check.ps1:51 char:82
+ ... M Win32_ComputerSystem" | Select-Object -ExpandProperty RebootPending
+                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (\\DESKTOP-CLTV9...ESKTOP-CLTV936":PSObject) [Select-Object], PSArgumentException
    + FullyQualifiedErrorId : ExpandPropertyNotFound,Microsoft.PowerShell.Commands.SelectObjectCommand
 
No pending reboots found.
=================================
