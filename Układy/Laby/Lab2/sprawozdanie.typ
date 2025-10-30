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

#set page(margin:2cm)
#set text(size:18pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Treść zadania
Ćwiczenia składały się z dwóch zadań:
+ Wykorzystując pokrętło na płytce, utworzyć program który będzie zlicząć ilość kroków obrotu w daną stronę, a wartość wyświetlać na 4 diodach led na dany kierunek (8 diod łacznie). Dla jednego kierunku obrotu wartość wyświetlać na wyświetlaczu 7-segmentowym.
+ Utworzyć synchroniczny licznik modulo 7 wykorzystując przerzutniki typu D. Aktualną liczbę wyświetlać na 4 diodach, oraz na wyświetlaczu 7-segmentowym.
= Zadanie 1
== Schemat VHDL

== Opis schematu VHDL
= Zadanie 2
== Schemat VHDL
== Opis schematu VHDL
== Wyniki symulacji
= Wnioski