#set page(
  margin: 1cm,
)
#figure(image("\logo-pwr-2025\logo PWr kolor pion angbez tła.png", width:20%), numbering: none)
#set align(center)
#set text(size: 18pt)
#table(
  columns: 3,
  align: (center + horizon, center + horizon, left + horizon),
[*POLITECHNIKA*\
* WROCŁAWSKA*],
[*Autor*:\
 Daniel Gościński\
 280878],
[Wydział Informatyki i Telekomunikacji\
 \
 Rok:2025\
 Rok akadem.: 3],
table.cell(
    colspan: 3,
    align: center,
)[*Grafika komputerowa i komunikacja człowiek-komputer*],
table.cell(
    align: left,
)[*Data ćwiczenia: 05.11.2025*],
table.cell(
    rowspan: 2,
    align: left,
)[Temat ćwiczenia laboratoryjnego:\
 \
 Modelowanie obiektów 3D],
table.cell(
    rowspan: 2,
)[Prowadzący:\
 Dr inż. Arch.\
 Tomasz Zamojski],
table.cell(
    align: left,
)[*Nr ćwiczenia: 3*],
)



#set page(margin: 1.5cm,)
#set align(left)
#set heading(numbering: "1.")
#text(size:18pt)[
#outline(title: text(size: 42pt, weight: "bold")[Spis treści],
        )]
#pagebreak()
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Wstęp
Podczas zajęć zapoznano się z podstawowymi operacjami i sposobami tworzenia modeli 3D oraz poznanie zasady działania bufora głębi. Poznano również jak definiować bryły przy pomocy wierzchołków.

Przed przystąpieniem do wykonywania zadań zapoznano się z materiałem teoretycznym przygotowanym przez prowadzacego, gdzie lepiej zapoznano się ze sposobem opisu modelu 3D na przykładzie modelowania jajka.
= Opis zadań opracowanych w ramach laboratorium
Celem ćwiczenia było zaprezentowanie możliwości tworzenia obiektów 3D przy pomocy OpenGL poprzez utworzenie trójwymiarowego obiektu jajka na różne sposoby.
== Wykonane zadania
Wykonane zostały 4 zadania z listy zadań dostarczonej przez prowadzacego:
1. Utworzenie modelu jajka przy pomocy punktów
2. Utworzenie modelu jajka przy pomocy linii
3. Utworzenie modelu jajka przy pomocy trójkątów
4. Utworzenie modelu jajka za pomocą prymitywu paskowego
== Prezentacja i omówienie poszczególnych funkcjonalności
Plik źródłowy każdego z zadań bazowany jest na przykładowym pliku dostarczonym przez prowadzacego, na podstawie którego nastepnie wykonywane były zadania
=== Zadanie 1
Do pliku dołączonego do zadań
=== Zadanie 2
=== Zadanie 3
=== Zadanie 4
== Efekt wykonanej pracy
=== Zadanie 1
=== Zadanie 2
=== Zadanie 3
=== Zadanie 4
= Podsumowanie
= Literatura
#set par(justify:false,first-line-indent: (amount:0em,all:true))
[1] Handbook of Geometric Programming Using Open Geometry GL

[2] OpenGL Programming Guide. The Official Guide to Learning OpenGL, Version 1.1. OpenGL Architecture Review
Board: Mason Woo, Jackie Neider, Tom Davis. Addison-Wesley Developers Press,1997

[3] Strona internetowa dr inż. Szymona Datko: 
https://datko.pl/GK/

[4] Kanał YouTube Szymona Datko z omówionymi poszczególnymi laboratoriami dot. 
GRAFIKI KOMPUTEROWEJ: 
https://youtube.com/playlist?list=PLVFXq_zlHdh_lJQDQD8AjavN2TmNhFN-
P&si=aVqVD4ulVug4VCYI