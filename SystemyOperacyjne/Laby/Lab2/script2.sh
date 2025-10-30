#!/bin/bash
#
#
# TREŚĆ:
# Dany jest katalog K oraz plik zwykły P (parametry skryptu). W P znajdują się
# nazwy plików (końcówki, jedna na linię). Wypisz nazwy plików zwykłych z K,
# których nie ma w P oraz odwrotnie: tych z P, które nie są plikami zwykłymi w K.
# Można raz użyć zagnieżdżonego fora.
#
# 
shopt -s dotglob # Uwzględnij ukryte pliki
K=$1 # Argumenty [ katalog, plik z nazwami]
P=$2
arrayKinP=() # Tablice zapisujące ciągi znaków do późniejszego wyświetlenia
arrayP=()
checkPinK=1 # Zmienna pomocnicza aby sprawdzić istnienie plików z $P w katalogu $K tylko raz

for file in $K/* # Sprawdź każdy plik w katalogu $K
do
  existsKinP=0 # Zmienna zapisująca czy plik z katalogu $K  znajduje się w katalogu $P
  while read filename; # Przeczytanie po kolei nazw z pliku $P
  do
    existsPinK=0 # Zmianna zapisująca czy plik o nazwie z pliku $P znajduje się w katalogu $K
    if [[ $(basename $file) == $filename ]]; then # Jeżeli nazwa z pliku $P odpowiada nazwie pliku w katalogu $K zaktualizuj zmienną
      existsKinP=1
    fi
    if [[ $checkPinK == 1 ]]; then # Tylko w pierwszym kroku pętli głównej sprawdź czy nazwa pliku z $P występuje w katalogu $K
      for file2 in $K/*
      do
        if [[ $(basename $file2) == $filename ]]; then # Jeżeli nazwy są takie same, zaakutalizuj zmienną
          existsPinK=1
        fi
      done
      if [[ $existsPinK == 0 ]]; then # Jeżeli zmienna nie zostałą zaktualizowana (plik nie występuje w katalogu $K) dodaj nazwę do tablicy
        arrayPinK+="$filename\n"
      fi
    fi
  done < $P # Przekazanie pliku $P do wyczytania w pętli while
  if [[ $existsKinP == 0 ]]; then # Jeżeli zmienna nie została zaktualizowana (nazwa nie wystepuje w pliku $P) dodaj nazwe pliku do tablicy
    arrayKinP+="$(basename $file)\n"
  fi
  checkPinK=0
done
# Drukowanie zapisanych elementów tablic
printf "Pliki z katalogu K, których nazwy nie ma w pliku P\n"
printf "$arrayKinP\n\n"
printf "Nazwy z pliku P które nie występują jako pliki w katalogu K\n"
printf "$arrayPinK\n"
