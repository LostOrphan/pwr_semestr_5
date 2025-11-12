#!/bin/bash
#Numerowanie wszystkich plików w zadanym katalogu (parametr wywołania skryptu), do
#których mamy ustawione prawo wykonywania („execute”), przez dodanie dodatkowego
#członu rozszerzenia o postaci .<numer kolejny>. Numeracja powinna przebiegać według
#wielkości plików.

if [ $# -lt 1 ]; then
        echo "Wykonanie programu: $0 <katalog>"
        exit 1
fi
katalog="$1"

if [ ! -d "$katalog" ]; then
	echo "Katalog $katalog nie istnieje"
	exit 1
fi
i=1
find "$katalog" -maxdepth 1 -type f -executable -printf "%s %p\n" | sort -n  | while read -r size file; do
	nowaNazwa="${file}.${i}"
	mv "$file" "$nowaNazwa"
	echo "Zmieniono: $file -> $nowaNazwa"
	i=$((i+1))
done
