#set page(
  margin: 2.5cm,
)

#align(center)[
  // --- Header section ---
  #text(size: 24pt)[
  *Politechnika Wrocławska* \
  Wydział Informatyki i Telekomunikacji \
  
  *Systemy Operacyjne Laboratoria*\
  Grupa 15 Tygodnie parzyste
  ]
  // Add space before title
  #v(4cm)

  // --- Title section ---
  #text(size: 24pt, weight: "bold")[Sprawozdanie z zajęć z dnia] \
  #text(size: 24pt, weight: "bold")[07.11.2025] \
  #text(size: 24pt, weight: "bold")[Zadanie nr. 3]\

  #v(7cm)

  // --- Author section ---
  #text(size: 18pt)[Autor: \
  Daniel Gościński 280878\
  ]
  #v(2cm)

  // --- Instructor section ---
  #text(size: 18pt)[Prowadzący: \
  dr. inż. Mariusz Makuchowski
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
#set page(margin:1.5cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))

= Treść zadania
Numerowanie wszystkich plików w zadanym katalogu (parametr wywołania skryptu), do których mamy ustawione prawo wykonywania („execute”), przez dodanie dodatkowego członu rozszerzenia o postaci .\<numer kolejny>. Numeracja powinna  przebiegać według wielkości plików.
= Proces wykonania zadania
Zadanie znajdujące się w pliku *zad1.sh* oczekiwało od nas zmiany nazwy wszystkich plików, do których mamy prawa *executable*, dodając na koniec nazwy rozszerzenie w postaci .\<numer>. Pliki wowinny być numerowane według wielkości rozmiaru plików.

Skrypt zaczyna się od *\#\!\/bin\/bash* wskazujący położenie interpretera. Następnie poprzez prosty warunek *if*, sprawdzamy czy przy wykonywaniu skryptu podano argument, jeśli nie kończymy prorgam z kodem wyjściowym *1*. Drugi warunek *if* sprawdza, czy podany w argumencie katalog istnieje. Jeśli nie, program również kończy się z kodem *1*.

Główna część skryptu zaczyna się od ustawienia licznika *i* na wartość 1. Następnie wykonywane jest stosunkowo długie polecenie find łączone potokami, powodujące wykorzystanie wyniku jednego polecenia jako dane wejściowe drugiego polecenia. Rozkładając te długie polecenie uzyskujemy:
- *find "katalog"*: przeszukaj katalog o nazwie *katalog*
- *-maxdepth 1*: przeszukaj tylko katalog główny, nie wchodząc w podkatalogi
- *-type f*: szukaj tylko zwykłe pliki (ignorując katalogi czy linki)
- *-executable*: filtruj wynik, pokazując tylko pliki, do których mamy uprawnienia do wykonywania
- *-printf "%s %p\\n"*: wypisz wynik w postaci \<rozmiar pliku w bajtach> \<pełna ścieżka do pliku> \<znak nowej linii>
- *| sort -n*: wynik poprzedniego działania posortuj względem rozmiarów pliku (wartości numerycznej)
- *| while read -r size file; do*: dla każdego wiersza z poprzedniego działania przypisuje rozmiar do zmiennej size oraz ścieżkę do zmiennej size, następnie rozpoczynana się pętla do iterująca przez wszystkie uzyskane pliki.

Wewnątrz pętli wykonujemy prostą podmianę nazwy na nową nazwę zawierającą liczbę określającą jej numer oraz większenie wartości iteratora *i*. Dodatkowo wykonywane zmiany wypisywane są w konsoli przy pomocy *echo* w celu łatwiejszego podglądu działania programu.

#figure(image("zadanie.png", width:70%),caption: [Wynik działania skryptu nr. 1],supplement: [Zdjęcie])

= Wnioski
Zadanie zostało poprawnie wykonane, zgodnie z jego treścią. W wyniku tworzenia skryptu zapoznano się w zakresie podstawowym z pojęciem potoku, sposobem łączenia poleceń oraz utrwalono składnię oraz działanie *if* oraz sposobu iterowania przez zawartość folderu lub wynik działania innego polecenia (*do ... done*). Wiedza ta zostanie użyta w w celu wykonywania dalszych zadań.
= Literatura
1. Podręcznik systemowy linux, wywoływany lokalnie poleceniem man [nazwa szukanego polecenia], dostęp online https://man.he.net [dostęp: 29.10.2025]. W~dniu dostępu strona działała
2. https://stackoverflow.com/ [dostęp 29.10.2025]. W dniu dostępu strona działała 