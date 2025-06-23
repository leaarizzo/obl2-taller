#!/bin/bash

alta_producto() {
    if [ ! -f sesion.txt ] || [ ! -s sesion.txt ]
    then
        echo "Debes iniciar sesión para agregar productos."
        return
    fi

    read -p "Nombre del producto: " nombre
    read -p "Descripción: " descripcion

    read -p "Precio: " precio
    if ! [[ "$precio" =~ ^[0-9]+$ ]]
    then
        echo "Precio inválido."
        return
    fi

    read -p "Stock: " stock
    if ! [[ "$stock" =~ ^[0-9]+$ ]]
    then
        echo "Stock inválido."
        return
    fi

    # si ya existe, eliminarlo primero
    if grep -q "^$nombre:" productos.txt
    then
        grep -v "^$nombre:" productos.txt > temp.txt && mv temp.txt productos.txt
        echo "Producto existente reemplazado con nuevos datos."
    fi

    # agrego el nuevo producto (nuevo o actualizado)
    echo "$nombre:$descripcion:$precio:$stock" >> productos.txt
    echo "Producto guardado correctamente."
}
