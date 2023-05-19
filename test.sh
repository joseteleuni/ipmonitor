ip_public=168.121.47.126
ip_vpn=1.1.1.1

read_actual(){

    ip=$(curl ifconfig.me)

    if [ "$ip" != "$ip_public" ]; then
        
	    ip=$ip_vpn
    fi

    echo $ip
}

x=$(read_actual)
echo $x
