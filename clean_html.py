import re

with open(r"C:\Users\lenovo\.gemini\antigravity\scratch\kiralik-kepce\index.html", "rb") as f:
    raw = f.read()

# Replace replacement bytes \xef\xbf\xbd with empty string or specific fixes
text = raw.decode('utf-8', errors='ignore')

# Fix known words
text = text.replace("Giri Ekranına Dön", "Giriş Ekranına Dön")
text = text.replace("Do rudan", "Doğrudan")
text = text.replace("ıkış", "Çıkış")
text = text.replace("KEP E", "KEPÇE")
text = text.replace("KEP ENİ", "KEPÇENİ")
text = text.replace("rn:", "Örn:")
text = text.replace("İLAN", "İLAN")
text = text.replace("YE", "ÜYE")

with open(r"C:\Users\lenovo\.gemini\antigravity\scratch\kiralik-kepce\index.html", "w", encoding="utf-8") as f:
    f.write(text)

print("HTML Cleaned successfully!")
