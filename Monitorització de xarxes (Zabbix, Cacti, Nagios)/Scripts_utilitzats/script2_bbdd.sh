#Bolcat de MySQL:

#Còpia de seguretat de la BD
mysqldump -u usuari -p nom_de_la_base_de_dades > fitxer_de_sortida.sql

#Entrar a MySQL/MariaDB:
mysql -u root -p

#Llistar les BD dins de la instància:
show databases;

#Eliminar BD danyada de Zabbix (compte):
DROP DATABASE mydatabase;

#Crear nova BD amb el nom exacte que tenia anteriorment:
CREATE DATABASE nom_de_la_base_de_dades CHARACTER SET utf8 COLLATE utf8_bin;

#Importar la còpia de seguretat de la BD de Zabbix
mysql -u usuari -p nom_de_la_base_de_dades < backup.sql