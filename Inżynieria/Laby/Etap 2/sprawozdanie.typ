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
  #text(size: 24pt, weight: "bold")[Sprawozdanie z drugiego etapu] \
  #v(0.01cm)
  #text(size: 24pt, weight: "bold")[System Obsługi Dostaw Kurierskich]
  #v(1cm)
  #text(size: 24pt, weight: "bold")[Modelowanie realizacji przypadków użycia] \
  #text(size: 24pt, weight: "bold")[06.11.2025]

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
  margin: 2cm,
)

#set heading(numbering: "1.")
#text(size:20pt)[
#outline(title: text(size: 42pt, weight: "bold")[Spis treści],
        )]
#pagebreak()
#set page(margin:2cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Opis tworzonego systemu
Utworzony system zajmuje się wsparciem działania usługi kurierskiej, wliczając w to obsługę zamówień, zarządzenie transportem, obłsugę przesyłek specjalnych, rozliczanie płatności, oraz panel administracyjny.
pozwalającego na zarządzenie użytkownikami systemu.
= Diagramy czynności
== PU02. Nadanie przesyłki
1. Diagram czynności
#figure(image("Diagram1.png", width:120%),caption: [Diagram czynności dla PU02],supplement: [Zdjęcie])
2. Opis słowny
Danymi wejściowymi czynności są *dane zalogowanego użytkownika*, które trafiają do akcji *Podanie danych odbiorcy* w momencie zainicjalizowania przypadku użycia przez zalogowanego użytkownika.

W każdej chwili użytkownik może anulować proces nadania, co wywołuje akcję *Anulowanie procesu nadania* kończąca całą czynność.

Po wykonaniu akcji *Podanie danych odbiorcy* oraz *Podanie adresu nadawcy* tworzony jest obiekt *Dane przesyłki*, który w zależności od wyboru użytkownika trafia do akcji wywołania operacji *Nadanie przesyłki specjalnej*, która wywołuje czynność o tej samej nazwie. Na podstawie tego wyboru tworzony jest obiekt *Dane przesyłki specjalnej* lub *Dane przesyłki standardowej*, które trafiają do partycji systemu, gdzie wykonywane są operacje *Rejestracja przesyłki* oraz *Wysłanie informacji o zarejestrowaniu przesyłki*. Po zakończeniu procesu partycji systemu użytkownik wykonuje akcję *Wyświetlenie informacji o statusie przesyłki*, która kończy całą czynność.

Akcja *Nadanie przesyłki specjalnej* może przekazać sygnał *Odrzucenie przesyłki specjalnej*, która wywołuje akcję *Wyświetlenie informacji o odrzuceniu przesyłki*, która kończy całą czynność.
#pagebreak()
=== Rozszerzenie PU02: PU03. Nadanie przesyłki specjalnej
1. Diagram czynności
#figure(image("Diagram2.png", width:100%),caption: [Diagram czynności dla PU03],supplement: [Zdjęcie])
2. Opis słowny
Danymi wejściowymi czynności są *Dane przesyłki*, które przekazywane są w wyniku wykonywania określonej ścieżku *PU02*. Dane te wchodzą do akcji *Podanie informacji o przesyłce*.

Partycja *system* *rejestruje informacje o przesyłce specjalnej*, w wyniku czego powstaje obiekt *Dane przesyłki specjalnej*. Obiekt ten trafia do partycji *Koordynator przesyłek specjalnych*, który wykonuje akcję *Weryfikacja informacji*. Na podstawie następnej akcji *Wybór opcji*, może zostać utworzony sygnał *Odrzucenie przesyłki specjalnej* w przypadku odrzucenia przesyłki, lub wywołanie akcji kończącej całą czynność *Nadanie przesyłki specjalnej*.
== PU12. Zarządzanie danymi pracowników firmy
1. Diagram czynności
#figure(image("Diagram3.png", width:120%),caption: [Diagram czynności dla PU12],supplement: [Zdjęcie])
2. Opis słowny
Kierownik Firmy w każdym momencie, gdy akcja czynności znajduje się w jego partycji może anulować czynność, wysyłając sygnał *Użytkownik anuluje edycję*, co wywołuje akcję *Anulowanie procesu edycji danych*, która kończy całą czynność.

Czynność rozpoczyna się w po wykonaniu akcji *Wybór opcji "Zarządzanie danymi pracowników"* przez *Kierownik Firmy*. Wykonanej tej akcji łączona jest razem z obiektem *Lista magazynów* utworzona przez partycję *system*, aby wykonać akcję *Wybór zakresu magazynów*. Tworzy to obiekt *wybrane magazyny*, który łączony jest z obiektem utworznonym przez partycję *system*
o nazwie *Lista pracowników* do akcji *Wczytanie listy pracowników*, który tworzy obiekt *Dane pracowników*, który trafia do partycji *Kierownik Firmy*.

Akcja *wybór pracownika do edycji* zawęża zawartość obiektu *Dane pracowników* oraz wywołuje akcję *Wyświetlenie formularza do edycji danych*. Zmodyfikowanie danych powoduję akcję systemu *Weryfikacja danych*. W zależności od rezultatu system wykonuję akcję *Zapisanie zmian w bazie*, lub wywołuje *Wyświetlenie komunikatu o błędzie* w przypadku braku poprawności wprowadzonych danych. Obie opcje niezależnie prowadzą do akcji wyświetlającej komunikat w partycji *Kierownik Firmy*. Wykonanie tych akcji powoduje zakończenie całej czynności.