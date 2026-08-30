$path = "C:\Users\lenovo\.gemini\antigravity\scratch\kiralik-kepce\index.html"
$bytes = [System.IO.File]::ReadAllBytes($path)
$rawText = [System.Text.Encoding]::UTF8.GetString($bytes)

# Double UTF-8 decode: convert current UTF-8 string to ISO-8859-1/Windows-1252 bytes, then read back as UTF-8
$latin1 = [System.Text.Encoding]::GetEncoding("iso-8859-1")
$misreadBytes = $latin1.GetBytes($rawText)
$fixedText = [System.Text.Encoding]::UTF8.GetString($misreadBytes)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($path, $fixedText, $utf8NoBom)
Write-Host "Encoding successfully restored!"
