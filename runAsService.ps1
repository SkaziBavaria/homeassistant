
# Powershell script that creates a task to run a VirtualBox VM as a service at startup(no need to login)
# Run in privileged mode

# Declare variables
$taskName = "Run Home Assistant VM at startup"
$taskDescription = "Task that runs a virtualbox vm as a service at startup in headless mode"
$vmName = "Home Assistant OS"
$taskPath = "User Custom"

# Create task
$action = New-ScheduledTaskAction -Execute "C:\PROGRA~1\Oracle\VirtualBox\VBoxManage.exe" -Argument "startvm $vmName --type headless"
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest
$setting = New-ScheduledTaskSettingsSet -RestartInterval (New-TimeSpan -Minutes 5) -RestartCount 3 -ExecutionTimeLimit 365 -AllowStartIfOnBatteries
Register-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Settings $setting -TaskPath $taskPath -TaskName $TaskName -Description $taskDescription
