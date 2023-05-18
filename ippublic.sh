#!/bin/bash

source /home/infopyme/ipmonitor/configuracion

# Función para recuperar la dirección IP pública
get_public_ip() {
    curl -sS https://api.ipify.org
}

# Función para leer la dirección IP anterior desde un archivo
read_previous_ip() {
    if [ -f "$IP_FILE" ]; then
        cat "$IP_FILE"
    fi
}

# Función para escribir la dirección IP actual en un archivo
write_current_ip() {
    curl -u $user:$token "https://members.dyndns.org/v3/update?hostname=$hostname&myip=$current_ip"
    echo "$1" > "$IP_FILE"
}


while true; do
    # Recuperar la dirección IP actual
    current_ip=$(get_public_ip)

    if [ -n "$current_ip" ]; then
        previous_ip=$(read_previous_ip)
        if [ "$current_ip" != "$previous_ip" ]; then
            echo "La dirección IP ha cambiado!">>/var/log/ipservices.log
            echo "Dirección IP anterior: $previous_ip y la Dirección IP actual: $current_ip">>/var/log/ipservices.log
            write_current_ip "$current_ip"
            
        fi
    else
        echo "Error al recuperar la dirección IP pública.">>/var/log/ipservices.log
    fi

    # Intervalo de tiempo entre las verificaciones (en segundos)
    sleep 60
done
