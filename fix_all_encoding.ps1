$enc = New-Object System.Text.UTF8Encoding($false)
$baseDir = "C:\Users\lenovo\.gemini\antigravity\scratch\kiralik-kepce"
$files = @("app.js", "styles.css", "index.html")

foreach ($f in $files) {
    $path = Join-Path $baseDir $f
    $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    [System.IO.File]::WriteAllText($path, $content, $enc)
    Write-Host "Fixed: $f"
}
Write-Host "All files encoding fixed: UTF-8 no BOM"
