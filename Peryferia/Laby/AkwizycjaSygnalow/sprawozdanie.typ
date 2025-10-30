#set page(
  margin: 2.5cm,
)

#align(center)[
  // --- Header section ---
  #text(size: 24pt)[
  *Politechnika Wrocławska* \
  Wydział Informatyki i Telekomunikacji \
  
  *Urządzenia Peryferyjne Laboratoria*
  ]
  // Add space before title
  #v(4cm)

  // --- Title section ---
  #text(size: 24pt, weight: "bold")[Sprawozdanie z zadania nr.1] \
  #text(size: 24pt, weight: "bold")[Akwizycja Sygnałów] \
  #text(size: 24pt, weight: "bold")[13.10.2025]

  #v(7cm)

  // --- Author section ---
  #text(size: 18pt)[Autorzy: \
  Daniel Gościński 280878\
  Łukasz Duda 280916
  ]
  #v(2cm)

  // --- Instructor section ---
  #text(size: 18pt)[Prowadzący: \
  dr inż. Marek Piasecki
  ]
]
#pagebreak()
#set page(
  margin: 2.5cm,
)

#set heading(numbering: "1.")
#text(size:20pt)[
#outline(title: text(size: 42pt, weight: "bold")[Spis treści],
        )]
#pagebreak()
#set page(margin:2.5cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Cel ćwiczenia
Celem ćwiczenia było zapoznanie się z mechanizmem akwizycji sygnałów oraz sposobem w jaki można zbierać sygnały w celu wykorzystania danych w kodzie tworzonego programu. Do wykonania były zadania, których wynikiem końcowym był poprawny odczyt danych oraz ich interpretacja przez utworzony program.
= Zawartość pliku zip
W skompresowanym pliku o rozszerzeniu .zip znajdują się następujace pliki:\
- Folder measurment: znajduje się w nim program utworzony w C\#, zajmujacy się odczytem sygnału (wyjaśnienie w sekcji 4)
- Plik main.py: program utworzony w Pythonie, odczytujący dane zawierające się w piku *sensor_data.csv*, zamieniając je w wykres w programie okienkowym
- seonsor_data.csv: plik csv utworzony poprzez program measurment na podstawie odczytu z fizycznego generatora sygnału
- sprawozdanie.pdf: dokument zawierający sprawozdanie z zajęć
= Przebieg ćwiczenia
Przed przystąpieniem do zajęć w celach lepszego zrozumienia problemu przygotowano prymitywną wersję finalnego programu w Pythonie, która zapisywała do pliku .csv wyniki wyliczonej na podstawie wybranej funkcji generującej sinusoidę, a następnie odczytywała ten plik i generowała stosowny wykres z możliwością interakcji z nią. Z tym programem, oraz nabytą wiedzą teoretyczną o problemie przystąpiono do zajęć laboratoryjnych.

Po rozpoczęciu zajęć przystąpiono do zapoznania się z fizycznym sprzętem leżącym na stanowisku. Po odpowiednich wyszukiwaniach ustalono, że stanowisko składało się z:
- Generatora funkcji ORTEL G-5001
- Bloku rozdzielczego ADAM-3937 firmy ADVANTECH
- Modułu USB-4702 firmy ADVANTECH
#pagebreak()
W założeniu taka konfiguracja pozwalała na wygenerowanie sygnału sinusoidalnego, kwadratowego lub trókątnego o wybranej amplitudzie i częstotliwości, a sygnał ten w postaci cyfrowej można było odczytać na komputerze posiadającym odpowiednie sterowniki.
W internecie udało się zlokalizować program firmy ADVANTECH, pozawalający na odczyt sygnału generowanego przez generator.
#figure(image("oscyloskopTEST.png", width:70%),caption: [Zdjęcie programu wyświetlającego odczyt dla testowego urządzenia],supplement: [Zdjęcie])

Podłączone urządzenie generujące sygnał poprawnie przesyłało rezultaty przez port USB do komputera, co pozwałało na wyświetlenie ich w formie wykresu. Oznaczało to, że komputer poprawnie widział, i interpretował dane przesyłane z generatora.

Z uzyskaną wiedzą doinstalowano pliki przy pomocy instalatora *XNavi* które umożliwiają na komunikację z systemem DAQ z poziomu kodu. Zmodyfikowano program napisany w Pythonie o komunikację bazując na przykładowych plikach dostarczonych przez firmę ADVANTECH. Wykonane czynności wzorowane na przykładowych plikach nie pozwalały na poprawne uruchomienie programu, w wyniku czego rozpoczęto działania diagnostyczne.

Diagnostykę rozpoczęto od prób uruchomienia plików źródłowych przykładowych działań na systemie DAQ napisanych w języku Python. Zauważono, że nawet programy dostarczone ze sterownikami od firmy ADVANTECH nie działają poprawnie, wywołując błędy z pobraniem bibliotek. Spróbowano uruchomienia programu napisanego w innym języku programowania. Programy utworzone w języku C\# działały poprawnie, odpowiednio odczytując dane i wypisując je w konsoli. W wyniku działań diagnostycznych założono brak możliwości utworzenia działającego w pełni programu w Pythonie z powodu niekompletnych bibliotek. 

W wyniku diagnostyki dokonana została zmiana strategii, która została zaimplementowana do zadań po zakończeniu się zajęć laboratoryjnych. Wcześniej przygotowany program w Pythonie został zmodyfikowany, aby tylko odczytywał dane z pliku .csv, a następnie zamieniał go w odpowiednio interaktywny wykres. Utworzono nowy program w C\#, który zbierał dane generowane przez generator sygnału bazując na przykładowych plikach testowych. Ponieważ wiadomo, że pliki testowe działały poprawnie z podłączonym fizycznym urzadzeniem, program testowano na modelu "DEMODEVICE", co pozawalało na generowanie wyników bez fizycznego sprzętu. Oba programy działają prawidło, wykonując swoje zadane funkcje, w wyniku czego wykonano poprawnie narzucone zadanie. 
= Opis działania programów
== Program main.py (część Pythona)
Program po uruchomieniu (zakładając posiadane wszystkie używane biblioteki) odczyta dane z pliku *sensor_data.csv* (ważne jest aby plik znajdował się w tym samym folderze co program) a nastepnie wyświetli jego graf w oknie programu. Program umożliwia również na powiększanie, jak i oddalanie programu.
#figure(image("pythonFull.png"),caption: [Zdjęcie programu napisanego w Pythonie], supplement: [Zdjęcie] )
== Prorgam measurement (część C\#)
Program po uruchomieniu wypisze zebrane dane o sygnale do pliku *sensor_data.csv*. Należy zaznaczyć, że aktualna forma programu posiada podłączone DEMODEVICE, ze względu na wykonywanie zadania w momencie braku dostępu do urządzenia fizycznego. Wiadomo jednak, że plik testowy poprawnie odczytywał dane po podłaczeniu fizycznego urządzenia, więc zmiana danych urządzenia na *USB-4702* (zakładając, że urządzenie jest podpięte do komputera) powinno poprawnie odczytywać dane generatora sygnału.
= Wnioski
Najważniejsza wiedza nabyta podczas tych laboratoriów, to bycie świadomym, że nawet producent nie zawsze dostarcza odpowiednio działające oprogramowanie do swojego produktu, w wyniku czego należy posiadać wystarczające zdolności adaptacji do przedstawionej sytuacji, aby móc obejść problem. Nabyta została również wiedza z zakresu działania systemów DAQ, ścieżki jaką przebywa sygnał od punktu mierzonego aż do komputera.
= Podsumowanie
W wyniku wykonanego zadania zapoznano się z systemem akwizycji danych, sposobem podłączenia tego systemu do komputera oraz metodyki wykorzystania systemu w programie. Podczas wykonywanego zadania natrafiono na przeszkodzę, z którą poradzono sobie poprzez zmianę języka programowania wykorzystanego do odczytywania danych systemu DAQ.
= Skan raportu z zajęć
#figure(image("raport.png"))