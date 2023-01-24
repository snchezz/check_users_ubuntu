#/bin/bash

# Siguiendo las recomendaciones del punto “6.1. Cuentas de usuario”, una forma de determinar la validez de la cuenta es verificar si es propietaria de archivos y si es así, ver cuál fue la última fecha de modificación.
# Escribe el código para obtener la información siguiente, cuentas que:
# No tengan archivos.
# Los archivos han sido modificados hace más de 6 meses.
# Los archivos han sido modificados hace más de 1 año.
# Obtener las cuentas que cumplan el punto 1 y el 3.

echo "Elige una opcion
1. Mostrar listado de usuarios
2. Comprobar si tiene archivos
"

read opc
case $opc in
1)
    echo "1"
    ;;

2)
    echo "1"
    read user
    if id "$1" >/dev/null 2>&1; then
        echo "user exists"
    else
        echo "user does not exist"
    fi
    ;;

3)
    echo "Saliendo del sistema"
    exit
    ;;

*) echo "Opción incorrecta, para salir pulse 5" ;;
esac
