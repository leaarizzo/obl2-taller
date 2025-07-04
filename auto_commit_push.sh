#!/bin/bash

git diff --quiet HEAD

if ! [ "$?"  -eq 0 ]
then
	echo "Cantidad de lineas modificadas: " >> README.md
	git diff --numstat | awk '{a+=$1; e+=$2} END {print a + e}' >> README.md

	uptime | awk '{print$1}' >> README.md

	echo "" >> README.md

	git add .
	git commit -m "Auto-commit: $(date '+%Y-%m-%d')"

	git push --quiet
else
	echo "No se han realizado cambios desde el ultimo commit" >> README.md
	echo "" >> README.md
	git add README.md
	git commit -m "No han habido cambios: $(date '+%Y-%m-%d')"
	git push --quiet
fi
