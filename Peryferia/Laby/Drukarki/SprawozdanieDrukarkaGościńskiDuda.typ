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
  #text(size: 24pt, weight: "bold")[Sprawozdanie z zadania nr.2] \
  #text(size: 24pt, weight: "bold")[Druarki] \
  #text(size: 24pt, weight: "bold")[27.10.2025]

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
#set page(margin:2cm)
#set text(size:14pt)
#set par(justify: true, first-line-indent:(amount:2em,all:true))
= Cel ćwiczenia
Celem ćwiczenia było zapoznanie się z zasadami i językami programowania drukarek różnego typu. Do wykonania był program pozwalający na wydrukowanie wpisanego tekstu, oraz na modyfikację graficzną (pogrubienie, kursywa, podkreślenie, zmiana czcionki itd).  
= Zawartość pliku zip
W skompresowanym pliku o rozszerzeniu .zip znajdują się następujace pliki:\
- *SprawozdanieDrukarkaGościńskiDuda.pdf*: dokument zawierający sprawozdanie z wykonanego zadania
- *main.py*: kod źródłowy programu wykonanego w celu wykonania zadania  
= Przebieg ćwiczenia
Przed przystąpieniem do zajęć przygotowano się z zakresu wiedzy teoretycznej o standardach podłączania drukarek, językach sterowania drukarkami (ESC, PCL), Składanie kolorów (RGB, CMYK, HSL, HSV). Przenanalizowano również w internecie biblioteki Pythona pozwalające na komunikację z drukarką.

Po rozpoczęciu zajęć i zapoznaniu się z zakresem działań do wykonania przystąpiono do identyfikacji drukarki. Po wystarczających wyszukiwaniach zidentyfikowano drukarkę jako HP LaserJet 5l, która podłączona została podłączona złączem równoległym do komputera. Zapoznano się z instrukcją obsługi drukarki.

Rozpoczęto od próby prostego wydruku pojedyńczego słowa przy pomocy rozkazów PCL wykorzystując wiersza poleceń. Po poprawnym wydruku rozszerzono działanie o wydruk pliku z rozszerzeniem .txt, kopiując jego zawartość do *LPT3*, co przenosiło informacje bezpośrednio do drukarki.

Po zapoznaniu się z kodami pozwalającym na modyfikację wyglądu tekstu, rozpoczęto pisanie programu w języku Python, pozwalający na pisanie i modifykację tekstu, a następnie drukowanie go przy pomocy drukarki. Wykorzystując kody PCL oraz bibliotekę *pywin32* poprawnie udało wysłać, i wydrukować prosto zmodyfikowany tekst.

Następni rozpoczęto dodawanie usprawnień do programu. W wyniku końcowym udało się modyfikować czcionkę oraz modyfikować cały tekst. Nie udało się wprowadzić modyfikację fragmentów tekstu. Udało się wprowadzić selekcję sposobu wydruku pomiędzy portait i landscape.


= Opis działania programu
= Wnioski
= Podsumowanie
= Skan raportu z zajęć