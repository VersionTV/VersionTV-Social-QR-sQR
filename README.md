# Social-QR-SQR
 QR etiketleri ile yeni bir iletişim çözümü. QR etiketleri oluşturun ve yönetin. Ardından etiketleri tarayarak mesajlaşın veya bilgi paylaşın.

 ![SQR Şeması](/sunum/sema1.png)

Projemizin amacı, yönetilebilir QR kodlar üreterek gizlilik ve pratiklik odaklı yeni bir iletişim yolu oluşturmaktır.
# Etiket Oluştur, Düzenle ve Yönet
![Etiket Oluştur,Düzenle ve Yönet](/sunum/sunum1.png)
Hesabınıza Giriş yaptıktantan sonra uygulamamız üzerinden istediğiniz kadar "sQR" etiketi üretebilir ve paylaşarak çıktı alabilirsiniz.
Dilerseniz sonrasında etiketin içeriğini **Düzenleyebilir ve güncelleyebilirsiniz. Etiketi yeniden çıkartmanıza gerek yoktur**

# sQR Kodu Tara ve İletişim Kur

Projemizin temel amaçlarından birinin gizlilik olması nedeniyle  sQR kodlarının iletişimin 2 farklı yolu tasarlanmıştır.
## 1.Yöntem (Gizlilik odaklı)
Eğer etiket sahibi kişisel bilgilerini gizlemeyi seçtiyse etiketini tarayan diğer kullanıcılar uygulama üzerinden mesaj gönderebilir. Bu sayede telefon numarası, adres gibi kişisel bilgiye gerek kalmaz.
![sqr](/sunum/sunum21.png)
## 2.Yöntem (Hızlı ve Pratik)
Eğer kullanıcı telefon numarasını gizlemek istemiyorsa **(Örneğin arabaya numaratik koyma senaryosu)** bu bilgileri girebilir. Ve sQR etiketi tarayanlar direkt numaraya ulaşıp iletişim kurabilir.
![sqr2](/sunum/sunum22.png)
# Kullanıcı Dostu Arayüz
![sqr3](/sunum/sunum5.png)
Sade ve renkli materiyal kullanıcı dostu arayüz ve uygulama içi sQR tarayıcı.
# Etiketleri Taramak için Uygulamaya gerek yok!
![sqr4](/sunum/sunum4.png)
**Etiketinizi okumak isteyenlerin uygulamamıza sahip olmasına gerek yoktur.Kamera veya herhangi bir QR tarayıcı ile sQR Etiketinizdeki bilgilere ulaşılabilirler.**
# Kolayca Kayıt OL ve Giriş yap
![sqr5](/sunum/sunum3.png)
Adınız dışında hiç bir kişisel bilgi vermeden uygulamaya giriş yapabilirsiniz.

# KULLANIM SENARYOLARI
### Senaryo 1:
İstanbul’da araçlarda olası bir kaza veya yanlış park etmeyi uyarmak için bir çok kişi numaratik 
(araca telefon numarası yazma aracı) kullanıyor. Bu sayede sıkıntılı anlarda araç sahibiyle 
iletişim kurulabiliyor. Ancak bu numara taciz veya dolandırıcılık gibi bir çok açıdan kötüye 
kullanılabilir. Bunun yerine sQR etiketin taratılmasının ardından uygulama içi mesajlaşmayla
(eğer sahibi onay verirse numara paylaşımı ile) iletişim kurulabilir ve gizlilik korunmuş olur.
Bilgi çağının olduğu bu dönemde “veri” bir maden. Bu veriyi herhangi bir amaç için 
kullanabilirsiniz. O sebeple veriyi korumak , veriyi elde etmekten daha önemli bir hale geldi. 
Genel misyon ; uygulamanın bir araç olarak kullanılması lakin arka planda “güvenlik” konusu 
birinci önceliği ve temeli olacaktır.

### Senaryo 2: 
Uçağa binmeden önce kişi bavuluna bu QR kodu yapıştırır. Eğer bavul karışırsa bulan kişi kodu 
taratır ve o platformdan bavul sahibiyle iletişim kurabilir. Kişi anonim kalabilir kişisel telefon numarasını veya ismini paylaşmak zorunda kalmaz.

# PROJEYİ HAZIRLAYANLAR
+ **HASAN ARNAVUTOĞLU**
+ **CEREN DEMİREZEN**
+ **ONUR DOĞAN**

## Kullanılan Kütüphaneler ve Araçlar:
* flutter sdk
 * cloud_firestore: 4.17.0
 * cupertino_icons: 1.0.8
  * firebase_auth: 4.19.2
  * firebase_core: 2.30.0
  * fluttertoast: 8.2.5
  * ionicons: 0.2.2
  * path_provider: 2.1.3
  * provider: 6.1.2
  * qr_code_scanner: 1.0.1
  * qr_flutter: 4.1.0
  * share: 2.0.4





