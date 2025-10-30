#!/bin/bash
#
#
# TREŚĆ
# Dany jest katalog K (parametr skryptu). Wypisz zawartość plików zwykłych
# wewnątrz K, poprzedzając za każdym razem nagłówkiem z nazwą pliku.
#
#
shopt -s dotglob # Uwzględnij ukryte pliki
K=$1 # Argument z nazwą katalogu

for file in $K/* # Pętla przechodząca przez każdy plik w katalogu
do
    if [[ ! -d "$file" ]]; then # jeżeli plik nie jest katalogiem, napisz jego nazwę i wyświetl zawartość
        printf "$file\n"
        cat $file
        printf "\n"
    fi
done

