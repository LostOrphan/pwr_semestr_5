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
  #text(size: 24pt, weight: "bold")[Raport z zadania nr.3] \
  #text(size: 24pt, weight: "bold")[Temat 5: WiFi] \
  #text(size: 24pt, weight: "bold")[10.11.2025]

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
#set page(margin:2cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Wstęp
Na zajęciach dany był dostęp do dwóch stacji komputerowych, dwóch routerów ASUS RT-AX86S oraz dwóch kart sieciowych USB Asus USB-AX56. Ćwiczenia opierały się o sieć bezprzewodową WLAN bazującej na grupie protokołów IEEE 802.11, co jest najpopularniejszym standardem sieci bezprzewodowych. Sieć ta składa się z bezprzewodowej karty sieciowej, anteny oraz punktu dosępowego. Sieci WLAN wykorzystując nielicencjonowane pasma częstotliwości, najczęstszymi pasmami jest 2.4GHz oraz 5GHz, które nie wymagają lincencji na użytkowanie.
= Cel ćwiczenia
Celem ćwiczenia jest zapoznanie się z zagadnieniami dotyczącymi budowy, konfiguracji i pomiarów wydajności
bezprzewodowych sieci LAN zgodnych ze standardami z rodziny IEEE 802.11 z wykorzystaniem nowoczesnych
routerów ASUS RT-AX86S i kart sieciowych ASUS USB-AX56.
= Przebieg wykonywania zadań
Przed wykonywaniem zadań przeprowadzono podstawową konfigurację routera (zadanie 1), którego poprawny wynik zostały zweryfikowane podczas zajęć przez prowadzącego. Komputery w sieci poprawnie komunikowały się wzajemnie, oraz poprawnie można było wysłać pakiety do adresu bramy (adres ip routera).

== Zadanie 2. Kanały WiFi i interferencje.
Zmodyfikowano routery zgodnie z poleceniem (Pasmo 5GHz wyłączone, 2.4Ghz widoczne o nazwie "student_grupa5" oraz wireless mode ustawiony na legacy). Uruchomiono na telefonie aplikacje WiFi Analyzer, z której zaobserowowano następującą zajętość kanałów
#figure(image("analyzer.png", width:40%),caption: [Rezultat programu WiFi Analyzer],supplement: [Zdjęcie])
Na podstawie zdjęcia można wywnioskować, że:\
a) Wszystkie kanały posiadają dużą ilość sieci, gdzie najwięcej sieci znajduje się na kanałach 1,2,3,4.\
b) Analizując uzyskane zdjęcie najmniejsze zurzycie jest na kanałach 11,12,13,14 lub okolice kanałów 4,5. Uważamy, że są to najlepsze kanały do przypisania nowym punktom dostępowym.\

Wykonano następnie test stabilności połączenia, uruchamiając kilka filmów w wysokiej jakości w serwisie YouTube, jednocześnie wykonując polecenie ping -n 100 \<adres_ip_routera>.
#figure(image("rat1.png", width:60%),caption: [Wyniki testu stabilności],supplement: [Zdjęcie])
W celu porównania stabilności zmieniono kanał na *7*, a następnie wykonano identyczny test ponownie.
#figure(image("ratrouter.png", width:60%),caption: [Ustawienia routera, zmiana kanału WiFi],supplement: [Zdjęcie])
#figure(image("rat2.png", width:60%),caption: [Wyniki ponownego testu stabilności],supplement: [Zdjęcie])
Możemy zaobserwować, że w obu przypadkach nie zostały utracone pakiety, zmieniło się za to średnie opóźnienie pakietu pomiędzy komputerem a routerem. Uzasadnić to można mniejszym zajęciem kanału, w porównaniu do kanału na którym wykonywany był pierwszy test.
== Zadanie 3. Konfiguracja i weryfikacja standardów WiFi
W celu wykonania zadania wyłączono jeden z routerów, likwidując ryzyko kolizji sygnałów. Włączono sieć 5GHz, oraz zmieniono jej nazwę na "student_grupa5_5". Zadanie polegało na wykonaniu speedtestu dla każdej z sieci w poniższych wariantach technologi\
#pagebreak()
1. Sieć 2,4 GHz - „legacy”\
2. Sieć 2,4 GHz - „n only”\
3. Sieć 5 GHz - „legacy”\
4. Sieć 5 GHz - „N/AC/AX mixed”\
5. Sieć 5 GHz - „AX only” \
Po wykonaniu testów uzyskano poniższe wyniki
#table(columns:4,
[*Typ*],[*Ping*],[*Download [Mb/s]*],[*Upload [Mb/s]*],
[Sieć 2,4 GHz - „legacy”],[2],[16.56],[16.25],
[Sieć 2,4 GHz - „n only”],[3],[91.88],[86.07],
[Sieć 5 GHz - „legacy”],[2],[21.12],[21.26],
[Sieć 5 GHz - „N/AC/AX mixed”],[2],[140.40],[156.14],
[Sieć 5 GHz - „AX only”],[2],[202.09],[220.38],
)
#figure(image("24legacy.png", width:100%),caption: [Wyniki speedtestu dla trybu 2.4GHz - legacy],supplement: [Zdjęcie])
#figure(image("24n.png", width:100%),caption: [Wyniki speedtestu dla trybu 2.4GHz - n only],supplement: [Zdjęcie])
#figure(image("5legacy.png", width:100%),caption: [Wyniki speedtestu dla trybu 5GHz - legacy],supplement: [Zdjęcie])
#figure(image("5mix.png", width:100%),caption: [Wyniki speedtestu dla trybu 5GHz - N/AC/AX mixed],supplement: [Zdjęcie])
#figure(image("5ax.png", width:100%),caption: [Wyniki speedtestu dla trybu 5GHz - AX only],supplement: [Zdjęcie])
Na podstawie wykonanych testów możemy zauważyć wpływ technologii WiFi na prędkość. Widzimy na przykład, że sieć 5GHz w technologii *legacy* jest wolniejsza od sieci 2.4GHz w technologii *n only*. Największe wartości uzyskał pomiar dla sieci 5GHz w trybie AX only, który jest najnowszą dostepną technologią, która wymagała dodatkowego włączenia WIFI 6 w routerze.
== Zadanie 4. Tryb połączenia media bridge
W celu wykonania tego zadania zresetowano jeden z routerów do ustawień fabrycznych. Następnie przy konfiguracji wstępnej wybrano tryb *Media Bridge*. W konfiguratorze połączono router z siecią WiFi routera podłączonego zgodnie ze schematem do internetu, podłączono również oba komputery do routera ustawionego w media bridge. Po odczekaniu, aż router skończy konfigurację internet działał poprawnie, a urządzenia poprawnie mogły się komunikować.
#figure(image("bridgeping1.png", width:100%),caption: [Wyniki polecenia *ping* na pierwszym komputerze],supplement: [Zdjęcie])
#figure(image("bridgeping2.png", width:100%),caption: [Wyniki polecenia *ping* na drugim komputerze],supplement: [Zdjęcie])\

W wyniku nowego połaczenia router przydzielił inne adresy IP komputerom, niż podczas pierwotnej konfiguracji.
Poprawnie funkcjonował również dostęp do internetu.
#figure(image("bridgeinterent.png", width:100%),caption: [Poprawnie załadowana strona *google.com*],supplement: [Zdjęcie])

= Wnioski
Ze względu na brak czasu nie udało się wykonać zadania *nr. 5 Szerokość kanału WiFi a przepustowość*. Pozostałe zadania zostały wykonane zgodnie z ich treścią. 

Dzięki wykonanym ćwiczeniom lepiej zapoznano się ze sposobem konfiguracji sieci bezprzewodowej, zależości wykorzystanej technologii WiFi na prędkość, oraz dodatkowym sposobie łączenia routerów bezprzewodowo w sieci lokalnej z wykorzystaniem trybu *Media Bridge*.