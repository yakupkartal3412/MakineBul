const fs = require('fs');

const content = fs.readFileSync('C:\\Users\\lenovo\\.gemini\\antigravity\\scratch\\kiralik-kepce\\app.js', 'utf8');
const match = content.match(/const TURKEY_CITIES = ({[\s\S]*?});/);

if (!match) {
  console.log("TURKEY_CITIES veri kümesi bulunamadı!");
  process.exit(1);
}

const cities = eval("(" + match[1] + ")");
const keys = Object.keys(cities);

console.log("Toplam il sayısı:", keys.length);

const official81 = [
  "Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir",
  "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli",
  "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari",
  "Hatay", "Isparta", "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir",
  "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir",
  "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat",
  "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman",
  "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"
];

const missing = official81.filter(c => !keys.includes(c));
console.log("Resmi 81 listede olup eksik olan iller:", missing);

let totalDistricts = 0;
keys.forEach(c => {
  totalDistricts += cities[c].length;
  if (!cities[c] || cities[c].length === 0) {
    console.log("İlçesi boş olan şehir:", c);
  }
});

console.log("Toplam ilçe sayısı:", totalDistricts);
