$studioPath1 = "C:\Program Files\Android\Android Studio\bin\studio64.exe"
$studioPath2 = "C:\Program Files\Android\Android Studio"
$studioPath3 = "$env:LOCALAPPDATA\Android\Android Studio\bin\studio64.exe"

if (Test-Path $studioPath1) {
    Write-Host "Android Studio: KURULU"
} elseif (Test-Path $studioPath2) {
    Write-Host "Android Studio: KURULU (dizin mevcut)"
} elseif (Test-Path $studioPath3) {
    Write-Host "Android Studio: KURULU (LocalAppData)"
} else {
    Write-Host "Android Studio: KURULU DEGIL"
}

$javaCmd = Get-Command java -ErrorAction SilentlyContinue
if ($javaCmd) {
    Write-Host "Java: KURULU - $($javaCmd.Source)"
} else {
    Write-Host "Java: KURULU DEGIL"
}

$sdkPath = "$env:LOCALAPPDATA\Android\Sdk"
if (Test-Path $sdkPath) {
    Write-Host "Android SDK: MEVCUT - $sdkPath"
} else {
    Write-Host "Android SDK: BULUNAMADI"
}
