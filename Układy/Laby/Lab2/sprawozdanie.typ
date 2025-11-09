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
  #text(size: 24pt, weight: "bold")[Sprawozdanie z drugiego ćwiczenia] \
  #v(0.01cm)
  #v(4cm)
  #text(size: 24pt, weight: "bold")[29.10.2025]

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

#set page(margin:1.5cm)
#set text(size:18pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Treść zadania
Ćwiczenia składały się z dwóch zadań:
+ Wykorzystując impulsator na płytce, utworzyć program który będzie zlicząć ilość kroków obrotu w daną stronę, a wartość wyświetlać na 4 diodach led na dany kierunek (8 diod łacznie). Dla jednego kierunku obrotu wartość wyświetlać na wyświetlaczu 7-segmentowym.
+ Utworzyć synchroniczny licznik modulo 7 wykorzystując przerzutniki typu D. Aktualną liczbę wyświetlać na 4 diodach, oraz na wyświetlaczu 7-segmentowym.
= Zadanie 1
== Schemat VHDL
#figure(image("uklad1.png", width:120%),caption: [Schemat układu pierwszego zadania],supplement: [Zdjęcie])
== Opis schematu VHDL
Schemat posiada 4 obiekty wejściowe. *ROT_A* oraz *ROT_B* są sygnałami wejściowymi impulsatora (obrót w prawo i w lewo). *KEY7* jest przyciskiem na płytce, który resetować będzie stany liczników.

Moduł  *RotaryEnc* przyjmuje sygnały i interpretuje sygnały impulsatora. Wychodzącymi sygnałami są jednotaktowe impulsy.

Sygnały obrotu w lewo i w prawo przechodzą na 2 osobne 4 bitowe liczniki, których sygnały wychodzące są negowane i trafiają do magistrali odpowiedzialnej za działanie ledów na płytce. Dodatkowo dla obrotów w lewo sygnały wychodzące z licznika trafiają do modułu *HexTo7Seg*, który steruje wyświetlaczem 7-segmentowym.
== Wynik działania
Zgodnie z założeniami podanymi przez prowadzacego układ nie był symulowany, zamiast tego został bezpośrednio uruchomiony na płytce. Wynik działania był zgodny z oczekiwaniami, obroty impulsatorem poprawnie wyświetlały rosnące wartości na 4 diodach LED. Obroty w lewo poprawnie wyświetlały również liczbę na wyświetlaczu 7-segmentowym.
= Zadanie 2
== Schemat VHDL
#figure(image("uklad2.png", width:120%),caption: [Schemat układu drugiego zadania],supplement: [Zdjęcie])
== Opis schematu VHDL
Wiedząc, że utworzony ma zostać licznik modulo 7, utworzono tablice Karnaugha w celach minimalizacji układu.
#figure(image("karnaugh.png", width:110%),caption: [Tablice Karnaugha],supplement: [Zdjęcie])
W wyniku minimalizacji uzyskano równania logiczne, na podstawie których utworzono schemat układu.

Pierwszym sygnałem wejściowym jest sygnał *CLK_LF* pozyskiwany z generatora sygnału niskiej częstotliwości. Sygnał ten podłączony jest do wejścia CLK każdego przerzutnika typu D.

Drugi sygnał pozyskiwany z przycisku *Key7* służy do zresetowania stanów licznika. Każde wyjście przerzutników podłączone jest do inwertera, z którego sygnał trafia do magistrali *LED*, oraz w postaci niezanegowanej do magistrali Hex, która obsługuje wyświetlacz 7-segmentowy.

Pomiędzy przerzutnikami wykonywane są operacje logiczne zgodnie z uzyskanymi wzorami z tablic Karnaugha. 3-wejściowa bramka AND rejestruje wartość binarną 7, który wywołuje zresetowanie wszystkich liczników.
== Wyniki symulacji
W celu wykonania symulacji utworzono testbench
#figure(image("tb.png", width:110%),caption: [Zdjęcie testbencha symulacji],supplement: [Zdjęcie])
W procesie symulacji zadawany jest w pętli 7 razy sygnał '0' oraz '1' z czasem czekania 10ns. W ten sposób przetestowano działanie licznika.
#figure(image("sim.png", width:110%),caption: [Zdjęcie wyniku symulacji],supplement: [Zdjęcie])
Przed przystąpieniem do interpretacji wyników symulacji należy zaznaczyć, że sygnały wyjściowe są zanegowane, co oznacza, że przykładowo sygnał *110* będzie oznaczał wynik 1.

Analizując rezultaty możemy określić, że układ poprawnie zlicza od 0 do 6 oraz, że poprawnie zmienia swój stan z wartości *7* na *0*, co oznacza poprawnie wykonane zadanie.
= Wnioski
W wyniku działań wykonanych na laboratoriach poprawnie wykonano oba zadania. 