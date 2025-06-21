#!/bin/bash

git diff --quiet HEAD

if ! [ "$?"  -eq 0 ]
then
	echo "Cantidad de lineas modificadas: " >> README.md
	git diff --shortstat HEAD | awk '{print$5}' >> README.md
	echo "" >> README.md
	uptime | awk '{print$1}' >> README.md
	echo "" >> README.md
	git add .
	git commit -m "`date`"
	git push --quiet
else
	echo "No se han realizado cambios desde el ultimo commit" >> README.md
	git push --quiet
fi
