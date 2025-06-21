#!/bin/bash

git diff --quiet HEAD

if ! [ "$?"  -eq 0 ]
then
	echo "Cantidad de lineas modificadas: " >> README.md
	git diff --shortstat HEAD >> README.md
	git add .
	git commit -m "`date`"
	git push
else
	echo "No ha sido necesario realizar un commit ya que no se han realizado cambios" >> README.md
fi
uptime | awk '{print$1}' >> README.md
echo "  " >> README.md
