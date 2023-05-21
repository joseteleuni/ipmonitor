#!/bin/bash

source /home/infopyme/ipmonitor/configuracion

# Función para recuperar la dirección IP pública del dominio
get_public_ip() {
    curl -sS https://api.ipify.org
}

#Funcion que lee el valor del DNS 
read_dyndns(){

   dig +short $hostname
}

#Funcion que lee el valor actual de la IP publica
read_actual(){

    ip=$1

    if [ "$ip" != "$ip_publica" ]; then
        ip=$ip_vpn
    fi
     
    echo $ip
}

# Función para escribir la dirección IP publica en DynDNS
write_current_ip() {
    curl -u $user:$token "https://members.dyndns.org/v3/update?hostname=$hostname&myip=$1"
}


while true; do
    

    # Recuperar la dirección IP actual
    current_ip=$(get_public_ip)    
    ip_dyndns=$(read_dyndns)
    ip_actual=$(read_actual "$current_ip")

    if [ -n "$current_ip" ]; then

        if [ "$ip_dyndns" != "$ip_actual" ]; then

            echo "La dirección IP ha cambiado!">>/var/log/ipservices.log
            echo "Dirección IP anterior: $ip_dyndns y la Dirección IP actual: $ip_actual">>/var/log/ipservices.log
            write_current_ip "$ip_actual"
            
        fi
    else
        echo "Error al recuperar la dirección IP pública.">>/var/log/ipservices.log
    fi

    # Intervalo de tiempo entre las verificaciones (en segundos)
    sleep 60

done
