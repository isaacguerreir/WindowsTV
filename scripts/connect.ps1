  using namespace Windows.Devices.Enumeration
using namespace Windows.Foundation

# TV NAME PARAMETER: required
$tv_name = "MY_TV_NAME"

$null = [Windows.Devices.Enumeration.DeviceInformation, Windows.Devices.Enumeration, ContentType = WindowsRuntime]
$null = [Windows.UI.ViewManagement.ProjectionManager,Windows.UI.ViewManagement,ContentType = WindowsRuntime]

Add-Type -AssemblyName System.Runtime.WindowsRuntime

$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | ? { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]

Function Await($WinRtTask, $ResultType) {
 $asTask = $asTaskGeneric.MakeGenericMethod($ResultType)
 $netTask = $asTask.Invoke($null, @($WinRtTask))
 $netTask.Wait(-1) | Out-Null
 $netTask.Result
}

Function AwaitAction($WinRtAction) {
 $asTask = ([System.WindowsRuntimeSystemExtensions].GetMethods() | ? { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and !$_.IsGenericMethod })[0]
 $netTask = $asTask.Invoke($null, @($WinRtAction))
 $netTask.Wait(-1) | Out-Null
}

$selector = [Windows.UI.ViewManagement.ProjectionManager]::GetDeviceSelector()
$devices = Await ([Windows.Devices.Enumeration.DeviceInformation]::FindAllAsync($selector)) ([Windows.Devices.Enumeration.DeviceInformationCollection])

$my_tv = "nothing"
foreach ($device in $devices) {
	if ($device.Name -eq $tv_name) {
		$my_tv = $device
	}
}

if ($my_tv -ne "nothing") {
	AwaitAction ([Windows.UI.ViewManagement.ProjectionManager]::StartProjectingAsync(0, 0, $my_tv))
}



