#!/bin/bash

vender_producto() {
    if [ ! -f sesion.txt ] || [ ! -s sesion.txt ]
    then
        echo "Debes iniciar sesión para comprar productos."
        return
    fi

    read -p "Nombre del producto a comprar: " nombre
    read -p "Cantidad a comprar: " cantidad

    if ! [[ "$cantidad" =~ ^[0-9]+$ ]]
    then
        echo "Cantidad inválida. Debe ser un número."
        return
    fi

    mail=$(cat sesion.txt)
    linea=$(grep "^$nombre:" productos.txt)

    if [ -z "$linea" ]
    then
        echo "El producto no existe."
        return
    fi

    descripcion=$(echo "$linea" | cut -d':' -f2)
    precio=$(echo "$linea" | cut -d':' -f3)
    stock=$(echo "$linea" | cut -d':' -f4)

    if [ "$cantidad" -gt "$stock" ]
    then
        echo "Stock insuficiente. Solo hay $stock unidades disponibles."
        return
    fi

    nuevo_stock=$((stock - cantidad))

    #eliminar producto viejo
    grep -v "^$nombre:" productos.txt > temp.txt && mv temp.txt productos.txt

    #agregarlo con el nuevo stock
    echo "$nombre:$descripcion:$precio:$nuevo_stock" >> productos.txt

    #registrar la venta
    echo "$mail:$nombre:$cantidad" >> ventas.txt
    echo "Compra realizada con éxito."
}
	
