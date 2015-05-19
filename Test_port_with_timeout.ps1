
$socket = new-Object system.Net.Sockets.TcpClient 
        
$attempt = $socket.BeginConnect("PIServer",5450,$null,$null) 

# ミリ秒単位でのタイムアウト
# タイムアウトが送るとWaitOneの変数を降らしてみる
$result = $attempt.AsyncWaitHandle.WaitOne(120000,$false) 

If (-Not $result) {
    Write-Host 'タイムアウトが起こりました'
} Else {
    $error.clear()
    $socket.EndConnect($attempt) | out-Null 
    If ($Error[0]) {
        Write-Host "ポートが開いていない可能性があります"
        Write-warning ("{0}" -f $error[0].Exception.Message)
    } Else {
        Write-Host "ポートが開いています"
    }
}

