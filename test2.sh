hostname=penal002.dyndns.org

read_dyndns(){

   dig +short $hostname
}

x=$(read_dyndns)
echo  $x
