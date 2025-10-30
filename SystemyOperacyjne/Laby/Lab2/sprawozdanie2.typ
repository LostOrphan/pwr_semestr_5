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
  #text(size: 24pt, weight: "bold")[24.10.2025] \
  #text(size: 24pt, weight: "bold")[Zadanie nr. 2]\

  #v(5cm)

  // --- Author section ---
  #text(size: 18pt)[Autor: \
  Daniel Gościński 280878\
  Krystian Zientara 280872\
  Łukasz Duda 280916\
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
#set page(margin:2cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Treść zadania
*Zadanie 1.* Dany jest katalog K (parametr skryptu). Wypisz zawartość plików zwykłych wewnątrz K, poprzedzając za każdym razem nagłówkiem z nazwą pliku.

*Zadanie 2.* Dany jest katalog K oraz plik zwykły P (parametry skryptu). W P znajdują się nazwy plików (końcówki, jedna na linię). Wypisz nazwy plików zwykłych z K, których nie ma w P oraz odwrotnie: tych z P, które nie są plikami zwykłymi w K. Można raz użyć zagnieżdżonego fora.
= Założenia do wykonywania zadań
- Sprawdzenie argumentów skryptu (plus wychodzenie ze skryptu)
- Treść w komentarzu
- nie interesują nas drzewa katalogowe, tylko pierwszy poziom pliku
- podwójny for zabroniony (chyba że jawnie pozwolono), zabronione dalsze rzeczy
- zabroniony cd, ostrożnie z \*
- wszystkie pliki (ukryte, katalogi)
- nie tworzyć nowych plików, jesli nie trzeba
= Proces wykonania zadań
== Zadanie 1
Zadanie znajdujące się w pliku *script1.sh* oczekiwało od nas wypisania nazw oraz zawartości plików wewnątrz folderu podanego poprzez parametr skryptu.

Skrypt zaczyna się od linii *\#\!\/usr\/bin\/env bash*, co wskazuje powłoce jakiego interpretera użyć przy wykonywaniu skryptu. Następne wykorzystane polecenie  *shopt -s dotglob* modyfikuje zachowanie powłoki, pozwalając jej na włączenie do listy plików te, które zaczynają się od kropki (w systemach Linux rozpoczęcie się nazwy od kropki oznacza plik ukryty).

Dalej wykonane jest przypisanie argumentu do zmiennej. Argumenty, podawane razem ze skryptem przechowywane są w zmiennych zaczynającej się od cyfry 1. W naszym przypadku więc pod zmienną *\$1* znajduje się podany przez użytkownika katalog.

Następnie program sprawdza czy podany arguemnt jest istniejącym katalogiem., jeśli nie jest skrypt zostaje zakończony.

Ostatnią częścią zadania jest pętla *for*, która przechodząc przez wszyskie pliki w folderze, sprawdza czy plik nie jest folderem. Jeśli nie jest, wypisana na terminal zostaje nazwa pliku, a następnie jego zawartość. Wykorzystane zostało polecenie *printf* zamiast echo w celu wykorzystania znaku nowej linii, co zwiększa czytelność wyniku działania programu.

#figure(image("skrypt1wynik.png", width:70%),caption: [Wynik działania skryptu nr. 1],supplement: [Zdjęcie])

== Zadanie 2
Zadanie znajdujące się w pliku *script2.sh* oczekuje wypisania plików znajdujących się we wskazanym folderze, których nie ma we wskazanym pliku oraz na wykonaniu czynności odwrotnej - wypisania plików wpisanych w podany plik, których nie ma w podanym folderze.

Utworzony skrypt zaczyna się podobnie, rozszerzony został jednak o dodatkowe tablice, które będą przechowywać pliki spełniające odpowiednie warunki zadania.

Program również sprawdza poprawność wpisanych argumentów. W przypadku wprowadzenia błędnych parametrów program kończy pracę wcześniej, wyświetlając informację o poprawnym sposobie uruchomienia programu.

W pętli *for*, która przechodzi przez wszystkie pliki w katalogu, posiada w sobie pętle while, która przechodzi przez każdą linię podanego pliku. W niej sprawdzane jest jednocześnie, czy plik z folderu znajduje się w pliku, oraz czy nazwa pliku z pliku *P* znajduje się w folderze *K*. Końcowo, jeśli plik nie znajduje się w odpowiednich miejscach, nazwa pliku przechowywana jest w odpowiedniej tablicy.

Po zakończeniu wzsystkich pętli wypisywane są zawartości odpowiednich tablic, kończąc wykonywanie skryptu

#figure(image("skrypt2wynik.png", width:70%),caption: [Wynik działania skryptu nr. 2],supplement: [Zdjęcie])

= Wnioski
Wykonanie zadania zostały poprawnie wykonane, zgodnie z ich treścią. Zapoznano się lepiej ze sposobem interpretacji argumentów programu, ze~sposobami działania na plikach oraz na składni tworzenia pętli lub porównań logicznych. Wiedza nabyta po wykonaniu zadań pozwoli na łatwiejsze wykonywanie zadań na następnych zajęciach 
= Literatura 
1. Podręcznik systemowy linux, wywoływany lokalnie poleceniem man [nazwa szukanego polecenia], dostęp online https://man.he.net [dostęp: 29.10.2025]. W~dniu dostępu strona działała
2. https://stackoverflow.com/ [dostęp 29.10.2025]. W dniu dostępu strona działała