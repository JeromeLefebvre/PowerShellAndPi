[reflection.assembly]::loadwithpartialname("OSIsoft.PISDK") | out-null
[reflection.assembly]::loadwithpartialname("OSIsoft.PISDKcommon") | out-null
$pisdk = new-object PISDK.PISDKClass;
$async = New-Object PISDKCommon.PIAsynchStatusClass

$srv = $pisdk.Servers.DefaultServer

write-host -foregroundcolor Blue "Default Server: " $srv.Name 

$point = $srv.PIPoints.Item("Sinusoid")

$snapshot = $point.Data.Snapshot

write-host -foregroundcolor Green $point.name ' Snapshot:' $snapshot.Value','$snapshot.TimeStamp.LocalDate

$mode = [PISDK.DataRemovalConstants]::drRemoveAll

Write-Host $mode.GetType().FullName, $mode


$mode = [PISDK.BoundaryTypeConstants]::btInside 

Write-Host $snapshot.TimeStamp.ToString()



$mode = [PISDK.RetrievalTypeConstants]::rtBefore

$time = "*-3m"

$a = $point.Data.ArcValue("*-3m",$mode,$async)
Write-Host $a.Value

<#
}
Catch
{
    echo $_.Exception|format-list -force
    
}
#>
$startTime = "*-300s"
$endTime = "*"
$mode = [PISDK.DataRemovalConstants]::drRemoveAll
$point.Data.RemoveValues($startTime, $endTime, $mode, $async)
#$point.Data.RemoveValues('*-100s', '*', $mode, $async)

#$point.Data.Remo
#$point.Data.RemoveValues($point.TimeStamp.UTCSeconds - 100, $myPIValue1.TimeStamp.UTCSeconds, $mode, $null)

#$myPIPoint.Data.RemoveValues($myPIValue1.TimeStamp.LocalDate, $myPIValue1.TimeStamp.LocalDate, $mode, $null)


