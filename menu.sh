#!/bin/bash

# creo archivos si no existen
for archivo in usuarios.txt productos.txt ventas.txt
do
    if [ ! -f "$archivo" ]
    then
        touch "$archivo"
    fi
done

# importo funciones
source login.sh
source productos.sh
source ventas.sh

mostrar_menu() {
    echo
    echo "==== Menú ===="
    echo "1) Registrarse"
    echo "2) Iniciar sesión"
    echo "3) Cerrar sesión"
    echo "4) Agregar producto (requiere login)"
    echo "5) Comprar producto (requiere login)"
    echo "0) Salir"
    echo "=============="
}

opcion=""

while [ "$opcion" != "0" ]
do
    mostrar_menu
    read -p "Seleccione una opción: " opcion

    case "$opcion" in
        1) signup ;;
        2) login ;;
        3) logout ;;
        4) alta_producto ;;
        5) vender_producto ;;
        0) echo "Saliendo..." ;;
        *) echo "Opción no válida." ;;
    esac
done
