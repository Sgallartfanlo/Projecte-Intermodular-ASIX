# Preparació del nou servidor amb Ubuntu Server 24.04 per a instal·lar Zabbix

## 1. Selecció de l'idioma
Configuració inicial de l'idioma de l'instal·lador.
![Selecció d'idioma](img/Idioma.png)
*Es tria l'espanyol per facilitar la lectura del procés.*

## 2. Actualització de l'instal·lador
Gestió de versions del programari de base.
![Actualització](img/Actualitzaciò.png)
*S'ha decidit continuar sense actualitzar l'instal·lador a la versió 24.04.4.*

## 3. Tipus d'instal·lació
Selecció del paquet de base del sistema.
![Tipus d'instal·lació](img/Tipus_instal·laciò.png)
*S'ha seleccionat la instal·lació estàndard d'Ubuntu Server.*

## 4. Configuració del teclat
Distribució de tecles.
![Teclat](img/Teclat_Idioma.png)
*Configurat en Spanish/Spanish per defecte.*

## 5. Emmagatzematge i Particionat
Configuració del disc dur i LVM.
![Configuració de disc](img/Disc.png)
*S'utilitza el disc sencer amb un grup LVM.*

![Resum de particions](img/Disc%202.png)
*Resum final de les particions creades, incloent /boot i el volum lògic.*

## 6. Perfil d'usuari
Dades d'accés i identificació de la màquina.
![Usuari](img/Usuari.png)
*Nom del servidor: `zabbixserver`. Usuari: `aos`.*

## 7. Accés Remot (SSH)
Habilitació del protocol de comunicació segura.
![SSH](img/SSH.png)
*S'ha instal·lat el servidor OpenSSH per a la gestió remota.*

## 8. Snaps del servidor
Instal·lació de programari addicional.
![Snaps](img/Snaps.png)
*No s'han seleccionat paquets Snap addicionals en aquest pas.*

## 9. Finalització
Execució de les tasques de fons.
![Sistema](img/Sistema.png)
*Vista del log d'instal·lació mentre el sistema s'escriu al disc.*

## 9. Finalització
Iniciar sessiò dins de la màquina
![Sistema](img/Inici.png)
*Entrem dins de la màquina amba les credencials que li hem configurat durant l'instal·laciò*
---

## ✍ Comandes Utilitzades

Un cop finalitzada la instal·lació, s'han utilitzat els següents comandaments per a la verificació i actualització del sistema:

1. **Consultar l'adreça IP:**
   ```bash
   ip address

2. **Accedir com a superusuari (root):**
```bash
sudo -i

```

3. **Actualitzar la llista de repositoris i el sistema:**
```bash
apt update && apt upgrade -y

```
