## 1. Copiar la carpeta del ipmonitor a /home/infopyme ### 

## 2. Copiar el archivo ipmonitor.service a la carpeta : /etc/systemd/system ###
cp ipmonitor.service /etc/systemd/system

## 3. Crear el archivo ipservices.log en /var/log ###
cd /var/log <br>
touch ipservices.log <br>
chmod 777 ipservices.log <br> 

## 4. Activar el daemon ###
systemctl enable ipmonitor.service <br>
systemctl start ipmonitor.service  <br>
