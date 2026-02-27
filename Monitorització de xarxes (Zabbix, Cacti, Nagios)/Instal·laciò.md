# Instal·lació de Zabbix amb Apache, MariaDB i PHP (Ubuntu)

## 1) Instal·lar Apache i MariaDB

```bash
sudo apt install apache2 mariadb-server -y
```

---

## 2) Afegir el repositori per a PHP

```bash
sudo apt install ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository ppa:ondrej/php
```

---

## 3) Actualitzar els paquets del sistema

```bash
sudo apt update -y && sudo apt upgrade -y
```

---

## 4) Instal·lar PHP i extensions

### PHP 8.0

```bash
sudo apt install php8.0 libapache2-mod-php8.0 php8.0-common php8.0-fpm php8.0-cgi php8.0-bcmath php8.0-gd php8.0-imap php8.0-intl php8.0-apcu php8.0-cli php8.0-mbstring php8.0-curl php8.0-mysql php8.0-xml unzip -y
```

### PHP 8.1

```bash
sudo apt install php8.1 libapache2-mod-php8.1 php8.1-common php8.1-fpm php8.1-cgi php8.1-bcmath php8.1-gd php8.1-imap php8.1-intl php8.1-apcu php8.1-cli php8.1-mbstring php8.1-curl php8.1-mysql php8.1-xml unzip -y
```

### PHP 8.3

```bash
sudo apt install php8.3 libapache2-mod-php8.3 php8.3-common php8.3-fpm php8.3-cgi php8.3-bcmath php8.3-gd php8.3-imap php8.3-intl php8.3-apcu php8.3-cli php8.3-mbstring php8.3-curl php8.3-mysql php8.3-xml unzip -y
```

---

## 5) Comprovar la instal·lació de PHP

```bash
php -v
sudo systemctl restart apache2
```

---

## 6) Permetre accés remot a MariaDB

Editar el fitxer:

```bash
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```

Modificar la línia:

```
bind-address = 0.0.0.0
```

---

# Instal·lació de Zabbix

## a) Instal·lar el repositori de Zabbix

```bash
sudo wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb
sudo apt update
```

---

## b) Instal·lar el servidor, frontend i agent

```bash
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
```

---

## c) Crear la base de dades

Accedir a MariaDB:

```bash
sudo mysql -uroot -p
```

Dins del prompt de MySQL:

```sql
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'password';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
quit;
```

Importar l’esquema inicial:

```bash
sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
```

Desactivar l’opció:

```bash
sudo mysql -uroot -p
```

```sql
set global log_bin_trust_function_creators = 0;
quit;
```

---

## d) Configurar la base de dades a Zabbix

Editar el fitxer:

```bash
sudo nano /etc/zabbix/zabbix_server.conf
```

Modificar la línia:

```
DBPassword=password
```

---

## e) Reiniciar i habilitar serveis

```bash
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2
```

---

## f) Accedir a la interfície web

URL per defecte:

```
http://host/zabbix
```

---

# Solució error d’idioma

```bash
sudo dpkg-reconfigure locales
```

Seleccionar:

```
en_US.utf8
```

Reiniciar serveis:

```bash
sudo systemctl restart zabbix-server.service
sudo systemctl restart zabbix-agent.service
sudo systemctl restart apache2
```

---

# Repositoris Zabbix per Ubuntu ARM

```bash
sudo wget https://repo.zabbix.com/zabbix/6.2/ubuntu-arm64/pool/main/z/zabbix-release/zabbix-release_6.2-2%2Bubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.2-2+ubuntu22.04_all.deb
sudo apt update
```

---

Document basat en el fitxer original **Zabbix.txt** 
