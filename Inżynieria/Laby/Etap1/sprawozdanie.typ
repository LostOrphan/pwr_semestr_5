#set page(
  margin: 2.5cm,
)

#align(center)[
  // --- Header section ---
  #text(size: 24pt)[
  *Politechnika Wrocławska* \
  Wydział Informatyki i Telekomunikacji \
  
  *Inżynieria Oprogramowania Laboratoria*
  ]
  // Add space before title
  #v(4cm)

  // --- Title section ---
  #text(size: 24pt, weight: "bold")[Sprawozdanie z pierwszego etapu] \
  #v(0.01cm)
  #text(size: 24pt, weight: "bold")[System Obsługi Dostaw Kurierskich]
  #v(1cm)
  #text(size: 24pt, weight: "bold")[Modelowanie wymagań i przypadków użycia] \
  #text(size: 24pt, weight: "bold")[23.10.2025]

  #v(4cm)

  // --- Author section ---
  #text(size: 18pt)[Autorzy: \
  Daniel Gościński 280878\
  Michał Gładkojć 280885
  ]
  #v(1cm)

  // --- Instructor section ---
  #text(size: 18pt)[Prowadzący: \
  prof. dr hab. inż. Jan Magott
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
= Opis tworzonego systemu
Utworzony system zajmuje się wsparciem działania usługi kurierskiej, wliczając w to obsługę zamówień, zarządzenie transportem, obłsugę przesyłek specjalnych, rozliczanie płatności, oraz panel administracyjny.
pozwalającego na zarządzenie użytkownikami systemu.
= Opis miejsca wdrożenia
== Nazwa projektu
System Obsługi Dostaw Kurierskich, dalej zwana systemem.
== Klient
Prywatna firma zajmująca się usługami kurierskimi, dalej zwana firmą.
== Cel projektu
Wykonanie systemu informatycznego umożliwiającego na prowadzenie usług kurierskich, wliczając w to obsługę zamówień, zarządzenie transportem, obłsugę przesyłek specjalnych, rozliczanie płatności, oraz panel administracyjny pozwalającego na zarządzenie użytkownikami systemu.
== Zasoby ludzkie
Użytkownikami systemu są pracownicy firmy, oraz klienci korzystający z usług kurierskich:

1. Klient: Osoba lub firma zlecająca lub odbierająca przesyłkę. Ma możliwośc składania zamówień i śledzenie paczek. Zakłada się wielu klientów firmy.
2. Kurier: Realizuje fizyczny transport między adresami . Aktualizuje status przesyłki w systemie. Zakłąda się wielu pracowników na tej pozycji.
3. Spedytor: Planuje i koordynuje trasy dostaw, przydziela zlecenia kurierom, monitoruje postęp realizacji. Zakłada się kilku pracowników na tej pozycji na określony magazyn.
4. Magazynier: Obsługuje przyjęcia, składowanie i wydawanie przesyłek w magazynach. Zakłada się wielu pracowników na tej pozycji.
5. Kierownik Magazynu: Nadzoruje prace magazynierów. Zakłada się jednego pracownika na tej pozycji na określony magazyn.
6. Kierownik Firmy: Zarządza systemem kureirskim, analizuje raporty i statystyki, kontroluje efektywność procesów. Zakłada się jednego pracownika na tej pozycji.
7. Koordynator przesyłek specjalnych: Wyznaczona osoba zajmująca się przesyłkami potrzebujących specjalnego traktowania. Zakłada się jednego pracownika na tej pozycji.
== Przepisy i strategie
1. Firma działa na terenie pojedyńczego województwa.
2. Firma oraz klienci systemu są zobowiązani do przestrzegania przepisów Rozporządzenia Parlamentu Europejskiego i Rady (UE) 2016/679 z dnia 27 kwietnia 2016 r. (RODO) dotyczących ochrony danych osobowych.
3. Firma oferuje usługi klientom na podstawie jej własnego regulaminu, którego użytkownicy będą przestrzegać
4. Firma działa w zakresie umożliwianym przez odpowiednie porzepisy transportowe, oraz Prawo Polskie i Prawo Unijne.
5. System automatyzuje (gdzie możliwe) proces wymagany do wykonywania usług kurierskich.
6. Osobą zarządzającą firmą, oraz jej pracownikami jest Kierownik Firmy.
7. Osoby zarządzające magazynami, nazywane Kierownikami Magazynu, zajmują się kontrolą pracy przydzielonego magazynu oraz ich pracowników.
8. Klient nie może zostać usunięty z systemu, dopóki ma powiązaną ze sobą dostawę.
9. Firma nie prowdziła usług przed powstaniem systemu, w wyniku czemu nie wykonywane są prace konwertujące wcześniejsze zapisy.
== Dane techniczne
1. Przetwarzanie i przechowywanie danych przez system odbywa się na serwerze głównym, do którego wysyłane są wszystkie zapytania
2. Użytkownik systemu uzyskuje do niego dostęp z poziomu przeglądarki, łącząc się z aplikacją webową.
3. Kierownik magazynu może wykonywać zmiany na poziomie adminstracyjnym tylko dla swojego magazynu.
4. Spedytorzy mogą koordynować pracę kurierów wychodzącą tylko z ich przydzielonego magazynu.
5. Serwer istnieje na maszynie posiadającej system operacyjny Debian 11.
6. Aplikacja napisana jest w języku Java.
#set par(justify: true, first-line-indent:(amount:2em,all:false))
= Lista wymagań funkcjonalnych i niefunkcjonalnych
== Lista wymagań funkcjonalnych
F1. System umożliwia rejestrację nowego klienta w bazie danych firmy kurierskiej.\
F2. Klient może nadać przesyłkę standardową, która podlegać będzie standardowej procedurze transportu.\
F3. Klient może nadać przesyłkę wymagającej specjalnego traktowania, która podlegać będzie specjalnej procedurze, oraz będzie nadzorowana przez Koordynatora przesyłek specjalnych.\
F4. Klient może wyszukać przesyłkę po numerze przesyłki, uzyskując informację o jej statusie.\
F5. Kurier może oznaczyć przesyłkę jako "doręczoną".\
F6. Kierownik magazynu może modyfikować dane pracowników magazynu.\
F7. Kierownik magazynu widzi raporty oraz statystyki przydzielonego magazynu.\
F8. Kierownik Firmy może modyfikować dane wszystkich pracowników.\
F9. Kierownik Firmy widzi raporty oraz statystyki firmy.\
F10. Spedytor przydziela przesyłki kurierom.\
F11. Magazynier aktualizuje stan przesyłki w magazynie.\
F12. Koordynator przesyłek specjalnych widzi wszystkie przesyłki specjalne, oraz może je modyfikować.\
F13. Klient może stworzyć prośbę o usunięcie konta.\
F14. System umożliwia logowanie i uwierzytelnianie użytkowników zgodnie z ich rolą.\

== Lista wymagań niefunkcjonalnych
N1. Działania użytkownika systemu są obsługiwane i możliwie automatyzowane przez system.\
N2. Kierownicy mogą wykonywać działania pracowników podrzędnych.\
N3. Dane klientów i pracowników są przechowywane w sposób bezpieczny, zgodny z Rozporządzeniem Parlamentu Europejskiego i Rady (UE) 2016/679 (RODO).\
N4. System obsługuje maksymalnie 10 000 przesyłek, 10 000 pracowników oraz 10 000 klientów.\
N5. Dostęp do systemu przez pracownika jest możliwy jedynie po uwierzytelnieniu użytkownika.\
N6. System umożliwia równoczesną pracę wielu użytkowników bez utraty integralności danych.\
= Diagram przypadków użycia
#figure(image("diagram.png", width:120%),caption: [Diagram przypadków użycia],supplement: [Zdjęcie])

= Słowny opis każdego przypadku użycia
#set par(justify: true, first-line-indent:(amount: 1em, all: true))
*PU01. Rejestracja klienta:*

Cel:
- Rejestracja klienta.

Warunki wstępne:
- Klient nie posiada konta.
- System posiada mniej niż 10 000 klientów.

Warunki końcowe:
- Klient posiada konto.
- Realizacja F1.

Scenariusz:
1. Klient wybiera opcję rejestracja klienta.
2. Klient podaje imię, nazwisko, numer telefonu i adres email.
3. Klient podaje hasło.
4. Klient potwierdza konto.
5. Rejestracja klienta.

*PU02. Nadanie przesyłki standardowej:*

Cel:
- Nadanie przesyłki standardowej.

Warunki wstępne:
- Zrealizowano pomyślnie PU05. Logowanie Klienta.

Warunki końcowe:
- Paczka oczekuje na przydział kuriera.
- Realizacja F2.

Scenariusz:
1. Klient podaje danych odbiorcy.
2. Klient podaje adres wysłki.
3. Klient podaje adres odbioru.
4. Przesyłka oczekuje na przydzielenie kuriera.

*PU03. Nadanie przesyłki specjalnej:*

Cel:
- Nadanie przesyłyki specjalnej.
  
Warunki wstępne:
- Poprawnie zrealizowano PU05. Logowanie Klienta.
- Wybrano wariant przesyłki specjalnej.

Warunki końcowe:
- Przesyłka specjalna jest zaakceptowana.
- Przesyłka oczekuje na kuriera.
- Realizacja F3.

Scenariusz:
1. Klient podaje danych odbiorcy.
2. Klient podaje adresu wysyłki.
3. Klient podaje adresu dostawy.
4. Klient podaje informacje o przesyłce.
5. Przesyłka oczekuje na akceptację przez koordynatora przesyłek specjalnych.
6. Jeśli przesyłka zaakceptowana\
  6.1. Przesyłka oczekuje na kuriera.
7. W innym wypadku\
  7.1. Informacja o odrzuceniu przesyłki.
#pagebreak()
*PU04. Śledzenie przesyłki:*

Cel:
- Śledzenie przesyłki.

Warunki wstępne:
- Zrealizowano pomyślnie PU05. Logowanie Klienta LUB PU14. Logowanie tymczasowe.
- Przesyłka istnieje.

Warunki końcowe:
- Klient zna stan przesyłki.
- Realizacja F4 i N3.

Scenariusz:
1. Sprawdzenie czy klient ma przesyłkę.
2. Jeśli kilka przesyłek
2.1. Wybór przesyłki.
3. Jeśli przesyłka istnieje\
  3.1. Wyświetlenie stanu przesyłki.
4. W innym wypadku\
  4.1. Wyświetlenie informacji o braku przesyłki.

*PU05. Logowanie klienta:*

Cel:
- Uwierzytelnienie użytkownika.

Warunki wstępne:
- Użytkownik posiada konto.
- Użytkownik zna dane logowania.

Warunki końcowe:
- Użytkownik jest zalogowany.
- Realizacja N3.

Scenariusz:
1. Użytkownik podaje login i hasło.
2. Realizacja PU17. Logowanie.
2. Jeśli dane są poprawne\
  2.1. Uwierzytelnienie.
3. W innym wypadku\
  3.1. Infromacja o błędzie i PU01 Rejestracja Klienta.

*PU06. Oznaczenie przesyłki jako doręczonej:*

Cel:
- Oznaczenie przesyłki jako doręczonej.

Warunki wstępne:
- Pomyślnie zrealizowano PU16. Logowanie pracownika
- Użytkownik jest Kurierem.
- Przesyłka istnieje w systemie.
- Przesyłka nie jest doręczona.

Warunki końcowe:
- Przesyłka jest dostarczona.
- Realizacja F5.

Scenariusz:
1. Kurier doręcza przesyłkę.
2. Kurier oznacza przesyłkę jaką doręczoną.

*PU07. Aktualizacja stanu przesyłki w magazynie:*

Cel:
- Aktualizacja stanu przesyłki w magazynie.
  
Warunki wstępne:
- Poprawnie zrealizowanoPU16. Logowanie pracownika.
- Użytkownik jest Magazynierem.
- Przesyłka istnieje.
- Przesyłka jest w magazynie.

Warunki końcowe:
- Zaktualizowanie stanu przesyłki w magazynie.
- Realizacja F11.

Scenariusz:
1. Magazynier wprowadza numer przesyłki.
2. Jeśli przesyłka istnieje i jest w magazynie\
  2.1. Magazynier aktualizuje stan przesyłki.
3. W innym wypadku\
  3.1. Informacja o braku błędzie.
#pagebreak()
*PU08. Przydzielanie przesyłek kurierom:*

Cel: 
- Przydzielanie przesyłek kurierom.

Warunki wstępne:
- Poprawnie zrealizowanoPU16. Logowanie pracownika.
- Przesyłka istnieje.
- Przesyłka może być przydzielona do kuriera.

Warunki końcowe:
- Przesyłka jest przydzielona do kuriera.
- Realizacja F10.
  
Scenariusz:
1. Spedytor wybiera przesyłkę oczekującą na kuriera.
2. Spedytor przypisuje kuriera do przesyłki i ustala gdzie ją dostarczyć.

*PU09. Generowanie raportu magazynowego:*

Cel:
- Wygenerowanie danych statystycznych działania konkretnego magazynu w postaci raportu z zadanego okresu czasu.

Warunki wstępne:
- Poprawnie zrealizowanoPU16. Logowanie pracownika.
- Użytkownik jest Kierownikiem Magazynu LUB Użytkownik jest Kierownikiem Firmy.

Warunki końcowe:
- Wygenerowany raport.
- Realizacja F7.
  
Scenariusz:
1. Kierownik wybiera zakres raportu.
2. Raport zostaje wygnerowany.

*PU10. Generowanie raportu firmy:*

Cel:
- Wygenerowanie danych statystycznych działania firmy w postaci raportu okresowego z zadanego okresu czasu.

Warunki wstępne:
- Poprawnie zrealizowanoPU16. Logowanie pracownika.
- Użytkownik jest Kierownikiem Firmy.

Warunki końcowe:
- Wygenerowany raport.
- Realizacja F9.
  
Scenariusz:
1. Kierownik wybiera zakres danych raportu firmy.
2. Raport zostaje wygenerowany.

*PU11. Zarządzanie danymi pracowników magazynu:*

Cel:
- Modyfikacja danych pracowników firmy takich jak dane personalne, stanowisko, magazyn dla którego pracuje oraz ocena pracy.

Warunki wstępne:
- Poprawnie zrealizowanoPU16. Logowanie pracownika.
- Użytkownik jest Kierownikiem magazynu LUB Użytkownik jest Kierownikiem firmy.

Warunki końcowe:
- Zmiana danych pracowników firmy.
- Realizacja F6.
  
Scenariusz:
1. Kierownik modyfikuje dane tabeli zawierającej dane pracowników.
2. Jeżeli dane są poprawnie wpisane\
  2.1. Dane zostają zapisane przez system.
3. W innym wypadku \
  3.1. System informuje o braku możliwości wprowadzenia dancyh.

*PU12. Zarządzanie danymi pracowników firmy:*

Cel:
- Modyfikacja danych pracowników firmy takich jak dane personalne, stanowisko, magazyn dla którego pracuje oraz ocena pracy.

Warunki wstępne:
- Poprawnie zrealizowanoPU16. Logowanie pracownika.
- Użytkownik jest Kierownikiem Firmy.

Warunki końcowe:
- Dane tabeli przechowującej dane pracowników firmy są zmodyfikowane i zapisane
- Realizacja F8.

Scenariusz:
1. Kierownik Firmy modyfikuje dane tabeli zawierającej dane wszystkich pracowników.
2. Jeżeli dane są wprowadzone poprawnie\
  2.1. Dane zostają zapisane przez system
3. W innym wypadku\
  3.1. System informuje o braku możliwości wprowadzenia danych
  3.2. Dane zostają zapisane przez system.

*PU13. Nadzór przesyłek specjalnych:*

Cel:
- Nadzór przesyłek specjalnych.

Warunki wstępne:
- Poprawnie zrealizowanoPU16. Logowanie pracownika.
- Przesyłka specjalna istnieje.

Warunki końcowe:
- Koordynator przesyłek specjalnych nadzoruje stan przesyłek specjalnych.
- Realizacja F12.
  
Scenariusz:
1. Koordynator przesyłek specjalnych wybiera przesyłkę specjalaną.
2. Informacja o stanie wybranej przesyłki.
3. Jeżeli przesyłka nie jest zakceptowana\
  3.1. Koordynator przesyłek specjalnych wykonuje PU15 Akceptacja przesyłek specjalnych.

*PU14. Prośba o usunięcie konta:*

Cel:
- Usunięcie konta użytkownika.

Warunki wstępne:
- Zrealizowano pomyślnie PU05. Logowanie klienta.
- Użytkownik nie ma oczekujących przesyłek.

Warunki końcowe:
- Konto użytkownika zostaje usunięte.
- Realizacja F13 i N3.
  
Scenariusz:
1. Prośba o potwierdznie.
2. Jeżeli użytkownik nie ma żadnych przesyłek\
  2.1. Usunięcie konta.
  2.2. Wylogowanie.
3. W innym wypadku\
  3.1. Podanie powodu odmowy.

*PU15. Logowanie tymczasowe:*

Cel:
- Alternatywna metoda logowania dla klientów którzy nie mają konta, a chcą uzyskać informację o ich przesyłce.

Warunki wstępne:
- Klient zna numer przesyłki i przypisany numer telefonu.

Warunki końcowe:
- Tymczasowe zalogowanie klienta.
- Realizacja F4, F14, N3.
  
Scenariusz:
1. Klient podaje numer telefonu i numer przesyłki.
2. Sprawdzenie czy przesyłka istnieje.
3. Jeżeli dane są poprawne\
  3.1. Tymczasowe uwierzyteleniene klienta.
4. W innym wypadku\
  4.1. Infromacja o błędzie.

*PU16. Logowanie pracownika:*

Cel:
- Logowanie dla pracowników.

Warunki wstępne:
- Pracownik posiada konto.
- Pracownik zna dane logowania.

Warunki końcowe:
- Pracownik jest zalogowany.
- Realizacja N5
  
Scenariusz:
1. Pracownik podaje login i hasło.
2. Realizacja PU17. Logowanie.
3. Jeżeli dane są poprawne\
  3.1. Uwierzytelnienie.

*PU17. Logowanie:*

Cel:
- Logowanie.

Warunki wstępne:
- Inicjowane przez PU05. Logowanie klienta lub PU16. Logowanie pracownika.

Warunki końcowe:
- Powrót do PU05. 
- Logowanie klienta lub PU16.
- Logowanie pracownika.
  
Scenariusz:
1. Weryfikacja loginu i hasła.
2. Powrót do porzedniej funkcji.

