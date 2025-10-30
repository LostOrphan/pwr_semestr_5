#set page(
  margin: 2.5cm,
)

#align(center)[
  // --- Header section ---
  #text(size: 24pt)[
  *Politechnika Wrocławska* \
  Wydział Informatyki i Telekomunikacji \
  
  *Technologie Sieciowe Laboratoria*
  ]
  // Add space before title
  #v(4cm)

  // --- Title section ---
  #text(size: 24pt, weight: "bold")[Raport z zadania nr.1] \
  #text(size: 24pt, weight: "bold")[Szacowanie pasma] \
  #text(size: 24pt, weight: "bold")[14.10.2025]

  #v(7cm)

  // --- Author section ---
  #text(size: 18pt)[Autorzy: \
  Daniel Gościński 280878\
  Łukasz Duda 280916
  ]
  #v(2cm)

  // --- Instructor section ---
  #text(size: 18pt)[Prowadzący: \
  mgr. inż. Karol Puchała
  ]
]
#pagebreak()
#set page(
  margin: 2.5cm,
)

#set heading(numbering: "1.")
#text(size:18pt)[
#outline(title: text(size: 42pt, weight: "bold")[Spis treści],
        )]
#pagebreak()
#set page(margin:2.5cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Treść zadania
W firmie „student ustala nazwę firmy” pracuje 50 osób. Pracownicy przez  20% czasu pracy przeglądają strony
WWW. Na 5 stacjach przez cały dzień pracy uruchomione jest radio internetowe, na jednej stacji streaming
wideo. Wszyscy pracownicy do komunikacji wykorzystują komunikatory Discord, MS Teams, telefony VoIP oraz pocztę
elektroniczną. 5 razy w tygodniu odbywają się dwugodzinne wideokonferencje, w których uczestniczą 2
osoby/stacje. Administrator pobiera korzystając z FTP łatki, uaktualnienia, nowe wersje oprogramowania.
Administrator raz w tygodniu przesyła pełny backup bazy danych o rozmiarze 15 GB na zdalny serwer a
codziennie backup 1/5 danych.
= Opis firmy

= Opis sposobu generowania ruchu
Ruch internetowy w celach pomiarowych został wygenerowany w nastepujacy sposób:
- FTP: pomiar wykonany został poprzez przesłanie około 900 plików zdjęciowych przez serwer FTP (łączna waga plików wynosi około 200MB). Do transferu plików wykorzystano program *Filezilla*.\ Wykorzystany filtr programu Wireshark: *ip.addr==192.168.1.13*\ Uzasadnienie wykorzystanego filtru: podany adres był adresem lokalnego serwera FTP.
- Mail: pomiar wykonany został poprzez przesłanie jednego maila poprzez program Thunderbird.\ Wykorzystany filtr programu Wireshark: *ip.addr==74.125.71.108*\ Uzasadnienie wykorzystanego filtru: wysłanie maila na adres pocztowy \@pwr.edu.pl ukazywało w logach ruch TCP z protokołem SMTP gmaila.
- Radio: pomiar wykonany został poprzez zarejestrowanie 15 minutowej sesji słuchania radia wykorzystując program *inLight Radio* pobrany ze sklepu Microsoft.\ Wykorzystany filtr programu Wireshark: *ip.addr==185.171.67.24*\ Uzasadnienie wykorzystanego filtru: rozpoczęcie słuchania radia powodowało wzmożony ruch z, i do podanego adresu.
#pagebreak()
- VOIP: pomiar wykonany został poprzez zarejestrowanie 15 minutowej sesji rozmowy poprzez komunikator *Discord*. \ Wykorzystany filtr programu Wireshark:  *udp* \ Uzasadnienie wykorzystanego filtru: uruchomienie czatu głosowego wywołało wzmożony ruch UDP. Ponieważ program Discord był jedynym włączonym programem, uznano cały ruch UDP za ruch komunikacji VOIP.
- WWW: pomiar wykonany został poprzez zarejestrowanie 15 minutowej sesji korzystania z przeglądarki internetowej w sposób "naturalny" (Włączone wideo w servisie Youtube w jakości 1080p na jednym monitorze, na drugim regularne przeglądanie serwisów społecznościowych i wiadomości).\ Wykorzystany filtr programu Wireshark: *tcp.port==80 || tcp.port==443* \ Uzasadnienie wykorzystanego filtru: port tcp 80 przeznaczony jest dla komunikacji z protokołem HTTP. Port tcp 443 przeznaczony jest dla komunikacji z protokołem HTTPS.
= Analiza otrzymanych logów 
Po wykonaniu pomiarów otrzymano logi, które następnie zapisano. Na ich podstawie otrzymano następującą tabele: 
#align(center)[
#table(columns: 3,
table.header([Nazwa usługi],[Ilość zmierzonych bajtów [B]],[czas pomiaru [s]]),
align: center ,

[FTP],[211 423 786],[63.32],
[Mail],[7827],[0.73],
[Radio],[3 652 762],[217.2],
[VOIP],[1 949 570],[338.12],
[WWW],[187 966 476],[908.97]
)]
= Wyliczenia pasma i ruchu dla poszczególnych usług

asdasd
= Wyliczenie przepustowości łącza do Internetu dla firmy 
= Wybór i opis łącza
= Odpowiedzi na pytania
== Które z badanych usług mają profil ruchu symetryczny, a które asymetryczny?
== W jakich przypadkach w firmie niezbędne jest symetryczne łącze do Internetu?
== Co to jest CIR?
== Czy najważniejszym paramertem dla usługi sieciowej jest pasmo (przepustowość)?
== Jakie usługi sieciowe wymagają także zapewnienia innych parametrów sieci (wymień te parametry)?
== Czy cena za łącze interneterowe rośnie liinowo wraz z przepustowościa tego łacza?