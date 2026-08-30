$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\lenovo\.gemini\antigravity\scratch\kiralik-kepce\index.html"
$content = [System.IO.File]::ReadAllText($path)
[System.IO.File]::WriteAllText($path, $content, $enc)
Write-Host "Encoding fixed: UTF-8 no BOM"
