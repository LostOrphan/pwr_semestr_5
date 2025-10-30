#set page(
  margin: 2.5cm,
)

#align(center)[
  // --- Header section ---
  #text(size: 24pt)[
  *Politechnika Wrocławska* \
  Wydział Informatyki i Telekomunikacji \
  
  *Układy Cyfrowe i Systemy Wbudowane*
  ]
  // Add space before title
  #v(4cm)

  // --- Title section ---
  #text(size: 24pt, weight: "bold")[Sprawozdanie z pierwszego ćwiczenia] \
  #v(0.01cm)
  #v(4cm)
  #text(size: 24pt, weight: "bold")[15.10.2025]

  #v(4cm)

  // --- Author section ---
  #text(size: 18pt)[Autorzy: \
  Daniel Gościński 280878\
  Łukasz Duda 280916
  ]
  #v(1cm)

  // --- Instructor section ---
  #text(size: 18pt)[Prowadzący: \
  dr inż. Sławomir Sambor]
]
#pagebreak()
#set page(
  margin: 2.5cm,
)

#set heading(numbering: "1.")
#text(size:20pt)[
#outline(title: text(size: 42pt, weight: "bold")[Spis treści],
        )]

#set page(margin:2cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Treść zadania
Zadanie polegało na utworzeniu schematu pozwalającego na zapalanie diod na płytce ZL-9572 zgodnie z realizacją funkcji *f(x#sub[1],x#sub[2],x#sub[3],x#sub[4])* = Σ(0,3,5,7,11,15). Cztery pierwsze diody mają zawsze wyświetlać aktualnie wartość naciśniętą przyciskami, a piąta dioda ma zapalać się tylko we wskazanych wartościach, w innych przypadkach dioda jest zgaszona. Dodatkowo podłączony jest wyświetlacz 7-segmentowy, który zawsze wyświetla aktualną wartość.
= Schemat VHDL
W celu utworzenia schematu wykonano minimalizację funkcji uzyskanej z treści zadania przy pomocy siatki Karnaugha.
#figure(image("karnaugh.png", width:120%),caption: [Minimalizacja funkcji metodą siatki Karnaugha],supplement: [Zdjęcie])
Uzyskaną funkcję *f= (!x1!x2!x3!x4)+(!x1x2x4)+(x3x4)* zamieniono następnie na schemat.
#figure(image("schemat.png", width:120%),caption: [Schemat utworzonego układu],supplement: [Zdjęcie])
= Opis schematu VHDL
Utworzony schemat posiada 4 sygnały wejściowe *Key*, który wprowadzany jest bezpośrednio do bloku *HexTo7Seg*, który zajmuje się operacją wyświetlacza 7-segmentowego. Sygnały po odpowiedniej transformacji zgodnej z zadaną funkcją wychodzą sygnałem *LED*, które dalej idą na fizyczne diody LED. Należy zaznaczyć, że wynik operacji logicznych musi być zanegowany, ponieważ diody LED działają w logice ujemnej.
= Wyniki Symulacji
Symulację wykonano poprzez ustawienie bitów wejścia *Key* na wszystkie wartości z zakreu 0-15. Na tej podstawie utworzono testbench, którym wykonywano symulację.

#figure(image("testbench.png", width:50%),caption: [Kod testbencha zajmujący się ustawianiem sygnałów wejścia Key],supplement: [Zdjęcie])
Wykonana symulacja testbencha wskzuje na poprawne działanie układu, gdzie sygnał LED(4) poprawnie reaguje na wybrane w zadaniu sygnały
#figure(image("symulacja.png", width:120%),caption: [Wyniki symulacji],supplement: [Zdjęcie])
Należy zaznaczyć, że ponieważ diody LED płytki działają w logice ujemnej ('0' zapala diodę), sygnały LED są też w logice ujemnej.
Sygnał wchodzący do ukladu *d7s* nie są możliwe do symulacji, ponieważ układ ten traktowany jest jako "czarna skrzynka".
= Wnioski
Utworzony schemat poprawnie przeszedł symulację. Po załadowaniu programu do pamięci układu płytki, naciskanie diod LED poprawnie zapalało 4 ledy wskazujące na biniarny zapis wartości, a piąta dioda poprawnie zapalała się w wartościach 0,3,5,7,11,15. Uzyskane rezultaty wskazują na poprawnie wykonane zadanie.
#figure(image("działający układ.jpg", width:70%),caption: [Efekt działania układu dla wawrtości 11],supplement: [Zdjęcie])

Wykonane zadanie pozwoliło na zapoznanie się z podstawami obsługi programu pozwalającego na pisanie w języku VHDL. Zapoznano się z podstawami utworzenia projektu, dodwania plików źródłowych oraz podstawami tworzenia układów. Uzyskana wiedza pozwoli na dalsze wykonywanie zadań na zajęciach.