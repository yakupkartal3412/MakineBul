$enc = New-Object System.Text.UTF8Encoding($false)
$path = "C:\Users\lenovo\.gemini\antigravity\scratch\kiralik-kepce\styles.css"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# Remove all GPU-heavy blurs causing lag on mobile WebView
$content = $content -replace '-webkit-backdrop-filter:[^;\}\n]+;?', ''
$content = $content -replace 'backdrop-filter:[^;\}\n]+;?', ''
$content = $content -replace 'filter:\s*blur\([^\)]+\);?', ''

# Replace transparent glass cards with high-performance solid dark backgrounds
$content = $content -replace 'rgba\(15,\s*23,\s*42,\s*0\.45\)', 'rgba(15, 23, 42, 0.88)'
$content = $content -replace 'rgba\(255,\s*255,\s*255,\s*0\.08\)', 'rgba(30, 41, 59, 0.85)'
$content = $content -replace 'rgba\(255,\s*255,\s*255,\s*0\.12\)', 'rgba(30, 41, 59, 0.90)'

[System.IO.File]::WriteAllText($path, $content, $enc)
Write-Host "styles.css optimized for 60fps mobile WebView!"
