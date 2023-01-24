#/bin/bash

# No tengan archivos.
# Los archivos han sido modificados hace más de 6 meses.
# Los archivos han sido modificados hace más de 1 año.
# Obtener las cuentas que cumplan el punto 1 y el 3.

# https://github.com/snchezz

echo "Selecciona una opción"
echo "1: Ver usuarios y los archivos que tiene cada uno"
echo "2: Sin archivos"
echo "3: Archivos con mas de 6 meses"
echo "4: Archivos con mas de 1 año"
echo "5: Sin archivos y hace mas de 1 año"

# Leemos por teclado la opcion elegida por el usuario
read n

case $n in
1)
  getent passwd | while IFS=: read -r name password uid gid gecos home shell; do
    files=$(sudo find . -user $name | wc -l) 2>/dev/null
    echo "$name numeros de archivos: $files"
  done
  ;;
2)
  echo "Cuentas de usuario sin archivos:"
  # Con un bucle for, comprobamos los usuarios
  for user in $(awk -F: '{print $1}' /etc/passwd); do
    # Con un condicional, comprobamos si tiene archivos o no
    if [ $(find -user $user | wc -l) -eq 0 ]; then
      # Si no tiene archivos, se imprime el nombre del usuario
      echo $user
    fi
  done
  ;;
3)
  echo "Cuentas de usuario que no tienen archivos de hace mas de 6 meses:"
  # Con un bucle for, nombramos los usuarios
  for user in $(awk -F: '{print $1}' /etc/passwd); do
    # Comprobamos que los usuarios tengan archivos
    if [ -d $(find -user $user) ] && [ -f $(find -user $user) ]; then
      # Creamos variables como ultima vez modidicado, fecha actual y la diferencia de ambos
      last_modified=$(find -user $user -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | head -n 1)
      last_modified_date=$(date -d "$(echo $last_modified | awk '{print $1}')" +%s)
      current_date=$(date +%s)
      difference=$(((current_date - last_modified_date) / 60 * 60 * 24 * 30 * 6))
      # Si la diferencia es de mas de 180 dias (6 meses) mostramos el usuario
      if [[ $difference -gt 180 ]]; then
        echo $user
      fi
    fi
  done
  ;;
4)
  echo "Cuentas de usuario que no tienen archivos de hace mas de 6 meses:"
  # Con un bucle for, nombramos los usuarios
  for user in $(awk -F: '{print $1}' /etc/passwd); do
    # Comprobamos que los usuarios tengan archivos
    if [ -d $(find -user $user) ] && [ -f $(find -user $user) ]; then
      # Creamos variables como ultima vez modidicado, fecha actual y la diferencia de ambos
      last_modified=$(find -user $user -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | head -n 1)
      last_modified_date=$(date -d "$(echo $last_modified | awk '{print $1}')" +%s)
      current_date=$(date +%s)
      difference=$(((current_date - last_modified_date) / 60 * 60 * 24 * 30 * 6))
      # Si la diferencia es de mas de 365 dias (1 año) mostramos el usuario
      if [[ $difference -gt 365 ]]; then
        echo $user
      fi
    fi
  done
  ;;
5)
  echo "Cuentas de usuario que no tienen archivos posteriores a hace 1 año o no tiene archivos:"
  # Con un bucle for, nombramos los usuarios
  for user in $(awk -F: '{print $1}' /etc/passwd); do
    # Comprobamos que los usuarios tengan archivos
    if [ -d $(find -user $user) ] && [ -f $(find -user $user) ]; then
      # Creamos variables como ultima vez modidicado, fecha actual y la diferencia de ambos
      last_modified=$(find -user $user -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | head -n 1)
      last_modified_date=$(date -d "$(echo $last_modified | awk '{print $1}')" +%s)
      current_date=$(date +%s)
      difference=$(((current_date - last_modified_date) / 60 * 60 * 24 * 30 * 6))
      # Si la diferencia es de mas de 365 dias (1 año) mostramos el usuario
      if [ $difference -gt 365 ] && [ $(find -user $user | wc -l) -eq 0 ]; then
        echo $user
      fi
    fi
  done
  ;;

*) echo "Opción incorrecta, saliendo" ;;
esac
