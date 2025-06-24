
#!/bin/bash

signup() {
    read -p "Ingrese su mail: " mail

    if grep -q "^$mail:" usuarios.txt
    then
        echo "Ya estás registrado."
    else
        read -s -p "Ingrese su password: " password
        echo
        echo "$mail:$password" >> usuarios.txt
        echo "Cuenta creada exitosamente."
    fi
}

login() {
    read -p "Ingrese su mail: " mail
    read -s -p "Ingrese su password: " password
    echo

    if grep -q "^$mail:$password$" usuarios.txt
    then
        echo "$mail" > sesion.txt
        echo "Inicio de sesión exitoso."
    else
        echo "Mail o password incorrectos."
    fi
}

logout() {
    if [ -f sesion.txt ]
    then
        rm sesion.txt
        echo "Sesión cerrada."
    else
        echo "No hay sesión activa."
    fi
}
