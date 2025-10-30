#set page(
  margin: 1cm,
)
#figure(image("logo PWr kolor pion ang  bez tla.png", width:20%),numbering: none)
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
)[*Data ćwiczenia: 22.10.2025*],
table.cell(
    rowspan: 2,
    align: left,
)[Temat ćwiczenia laboratoryjnego:\
 \
 Podstawy OpenGL, grafika 2D],
table.cell(
    rowspan: 2,
)[Prowadzący:\
 Dr inż. Arch.\
 Tomasz Zamojski],
table.cell(
    align: left,
)[*Nr ćwiczenia: 2*],
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
Podczas zajęć zapoznano się z podstawowymi operacjami z wykorzystaniem OpenGL poprzez wykonywanie różnych przekształceń obrazu. Zadania zostały wykonane w języku programowania Python z biblioteką PyOpenGL.

Przed przystąpieniem do wykonywania zadań zapoznano się z podstawywmi funkcjami biblioteki, takie jak:
- *glColor3f* - zajmuje się definiowaniem koloru
- *glBegin / glEnd* - zajmują się definiowaniem początku/końca rysowania
- *glVertex2f* - zajmują się definiowaniem położenia punktów
Zainstalowao również wymagane dowiązania (PyOpenGL oraz GLFW  ) 
= Opis zadań opracowanych w ramach laboratorium
Celem ćwiczenia było zaprezentowanie możliwości biblioteki OpenGL wraz z rozszerzeniem GLUT (GL Utility Toolkit) poprzez wykonanie elementarych operacji pokroju tworzenia prymitywów w przestrzeni 2D oraz deklarowania kolorów wierzchołków. Zadaniem wieńczącym było narysowanie Dywanu Sierpińskiego z zadaną skalą samopodobieństwa.
== Cel ćwiczenia
Celem ćwiczenia było zapoznanie się z podstawowymi operacjami umożliwianymi przez interfejs OpenGL w wymiarze 2D.

== Wykonane zadania
Wykonane zostało 5 zadań z listy zadań dostarczonej przez prowadzącego:
1. Narysowanie trójkąta, którego każdy wierzchołek ma inny kolor.
2. Utworzenie funkcji pozwalającej na wygenerowanie prostokąta w podanym miejscu. 
3. Zmodyfikowanie funkcji z zadania 2, rozszerzając ją o losowość kolorów oraz o możliwość modyfikacji rozmiaru prostokąta współczynnikiem skalującym.
4. Narysowanie Dywanu Sierpińskiego, którego stopień samopodobieństwa podawany jest jako argument programu.
5. Narysowanie wybranego drugiego fraktalu, podobnie do zadania 4.

== Prezentacja i omówienie poszczególnych funkcjonalności
Plik źródłowy każdego z zadań bazowany jest na przykładowym pliku dostarczonym przez prowadzacego, na podstawie którego nastepnie wykonywane były zadania

=== Zadanie 1
Do pliku dołączonego do zadań zmodyfikowano funkcję render, w celu utworzenia pojedyńczego trójkąta.
#pagebreak()
```py
def render(time):
    glClear(GL_COLOR_BUFFER_BIT)

    glBegin(GL_TRIANGLES)
    glColor3f(1,0,0)
    glVertex2f(-50,0)
    glColor3f(0,1,0)
    glVertex2f(50,0)
    glColor3f(0,0,1)
    glVertex2f(0,50)
    glEnd()
    glFlush()
```
Powyższy kod tworzy pojedyńczy trójkąt, którego każdy z wierzchołków ma inny kolor (czerwony, zielony, niebieski), tworząc figurę zawierające różne miszkanki kolorów.
=== Zadanie 2
W zadaniu zamieniono funkcję render(), która od teraz wykonuje tylko polecenie glFlush(), który wyświetla narysowane obiekty na ekran. Utworzono nową funkcję rectangle, która przyjmuje koordynaty prawego górnego wierzchołka, oraz długość obu boku. Na tej podstawie tworzone są 2 trójkąty, które łącznie tworzą oczekiwany prostokąt.
```py
def rectangle(x,y,a,b):
    glClear(GL_COLOR_BUFFER_BIT)

    glColor3f(0,0,100)
    glBegin(GL_TRIANGLES)
    glVertex2f(x,y)
    glVertex2f(x,y-b)
    glVertex2f(x+a,y-b)
    glEnd()

    glBegin(GL_TRIANGLES)
    glVertex2f(x,y)
    glVertex2f(x+a,y)
    glVertex2f(x+a,y-b)
    glEnd()
    
    render(glfwGetTime())
```
funkcja tworząca wybrany prostokąt, który składa się z 2 trójkątów.
=== Zadanie 3
Utworzoną funkcję do generowania prostokątów zmodyfikowano o nowy parametr, który modyfikuje wymiary prostokąta. Dodatkowo losowany jest jego kolor, który zmienia się co zadaną jednostkę czasu. 
```py
    horizontal=(a*d)+glfwGetTime()  #rozszerzają się z czasem trwania programu
    vertical=(b*d)+glfwGetTime()    #rozszerzają się z czasem trwania programu
    colorR=random.random()
    colorG=random.random()
    colorB=random.random()
```
Dodatkowo w celu rozszerzenia zadania do wymiarów dodawana jest jednostka czasu, co rozszerza prostokąty co każdy render figur.

Ponieważ uruchomienie programu spowodowałoby bardzo szybkie zmiany kolorów (kolory są generowane co każdą generację obrazu) dodano przed wywołaniem funkcji render() rozkaz *time.sleep(1)*, w celu spowolnienia działania prorgamu

W celu sprawdzenia działania wygenerowano 2 figury o następujących parametrach:
```py
        rectangle(-50,50,50,25,0.5)
        rectangle(-50,-50,50,25,1)
```
=== Zadanie 4
W celu utworzenia Dywanu Sierpińskiego wykorzystano wcześniej utworzoną funkcję generującą prostokąty, pozbawionej generacji losowych kolorów oraz funkcji sleep (ponieważ kolory nie są zmieniane nie ma potrzebny spowalniać procesu)

```py
def Sierpinski(x,y,dl,szer,d,color,stopien):
    if stopien == 0:
        rectangle(x, y, dl, szer, d, color)
        return
    rectangle(x, y, dl, szer, 1.0, (1.0, 1.0, 1.0))
    step = dl / 3.0
    for row in range(3):
        for col in range(3):
            if row == 1 and col == 1:
               continue
            nx = x + col * step
            ny = y - row * step
            Sierpinski(nx, ny, step, step, 1.0, color, stopien - 1)
```

Utworzona funkcja rekurencyjna sprawdza najpierw, czy stopien samopodobieństwa wynosi 0. Jeśli tak, generowany jest zwykły prostokąt. Jeśli wartość jest inna, wymiary dzielone są na 3 równe części, i dla każdego fragmentu wywoływana jest funkcja Sierpinski z nowymi wymiarami, oraz pomniejszonym stopniem o 1. Wynikiem końcowym jest uzyskany prawidłowo fraktal.

Program uruchamiany był poprzez polecenie *py ./zad4.py n*, gdzie n jest liczbą określającą stopien samopodobieństwa.
=== Zadanie 5
Drugim, wybranym fraktalem został trójkąt Sierpińskiego. W celu jego utworzenia napisano najpierw funkcję pozwalającą na tworzenie trójkątów równobocznych
```py
def draw_triangle(center, size):
    cx, cy = center
    h = math.sqrt(3) / 2 * size
    # Wierzchołki trójkąta równobocznego
    return [
        (cx - size / 2, cy - h / 3),
        (cx + size / 2, cy - h / 3),
        (cx, cy + 2 * h / 3)
    ]
```
Funkcja zwraca w tablicy wszystkie wierzchołki trójkąta. Następnie utworzono funkcję analogiczną do dywanu Sierpińskeigo, która rekurencyjnie generuje trójkąty
```py
def draw_sierpinski(vertices, depth):
    if depth == 0:
        glBegin(GL_TRIANGLES)
        for x, y in vertices:
            glVertex2f(x, y)
        glEnd()
    else:
        # Oblicz punkty środkowe boków
        midpoints = [
            ((vertices[0][0] + vertices[1][0]) / 2, (vertices[0][1] + vertices[1][1]) / 2),
            ((vertices[1][0] + vertices[2][0]) / 2, (vertices[1][1] + vertices[2][1]) / 2),
            ((vertices[2][0] + vertices[0][0]) / 2, (vertices[2][1] + vertices[0][1]) / 2),
        ]
        # Rekurencja dla trzech mniejszych trójkątów
        draw_sierpinski([vertices[0], midpoints[0], midpoints[2]], depth - 1)
        draw_sierpinski([vertices[1], midpoints[1], midpoints[0]], depth - 1)
        draw_sierpinski([vertices[2], midpoints[2], midpoints[1]], depth - 1)
```
Program uruchomiony przez polecenie *py ./zad5.py n* gdzie n jest liczbą określającą stopień samopodobieństwa poprawnie rysuje rekurencyjnie trójkąt Sierpińskiego.
#counter(figure).update(0)
== Efekt wykonanej pracy
=== Zadanie 1
#figure(image("zad1.png", width:50%),caption: [Efekt działania programu dla zadania 1],supplement: [Zdjęcie])
=== Zadanie 2
#figure(image("zad2.png", width:50%),caption: [Efekt działania programu dla zadania 2],supplement: [Zdjęcie])
=== Zadanie 3
#figure(image("zad3start.png", width:50%),caption: [Efekt działania programu dla zadania 3 po uruchomieniu programu],supplement: [Zdjęcie])
#figure(image("zad3end.png", width:50%),caption: [Efekt działania programu dla zadania 3 po upływie czasu],supplement: [Zdjęcie])
=== Zadanie 4
#figure(image("zad4_2.png", width:50%),caption: [Efekt działania programu dla zadania 4 dla stopnia saompodobieństwa 2],supplement: [Zdjęcie])
#figure(image("zad4_5.png", width:50%),caption: [Efekt działania programu dla zadania 4 dla stopnia saompodobieństwa 5],supplement: [Zdjęcie])
=== Zadanie 5
#figure(image("zad5_1.png", width:50%),caption: [Efekt działania programu dla zadania 5 dla stopnia saompodobieństwa 1],supplement: [Zdjęcie])
#figure(image("zadg5_2.png", width:50%),caption: [Efekt działania programu dla zadania 5 dla stopnia saompodobieństwa 5],supplement: [Zdjęcie])
#pagebreak()
= Podsumowanie
Tworzenie grafik 2D przy pomocy OpenGL wydaje się relatywnie proste, choć nadal potrzebna jest wiedza z zakresu obsługi biblioteki. Atutem jest możliwość szybkiego uruchomienia programu, co pozwala na graficzne zapoznanie się z wynikiem programu, dzięki czemu można szybko zauważyć błędy. Składnia nie wydaje się skomplikowana, pomimo długich nazw funkcji. Wiedza uzyskana w wyniku wykonania zadań pozwoli na późniejsze poszerzenie wiedzy oraz łatwiejsze wykonywanie zadań na następnych zajęciach.
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