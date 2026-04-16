# 📬 Configuració de Notificacions de Zabbix via Telegram

Aquesta guia explica pas a pas com integrar Zabbix amb Telegram per rebre alertes automàtiques quan es produeixen problemes en la infraestructura monitoritzada.

---

## Índex

1. [Crear el bot de Telegram amb BotFather](#1-crear-el-bot-de-telegram-amb-botfather)
2. [Obtenir el token del bot](#2-obtenir-el-token-del-bot)
3. [Cercar i iniciar el bot creat](#3-cercar-i-iniciar-el-bot-creat)
4. [Crear el grup de notificacions](#4-crear-el-grup-de-notificacions)
5. [Afegir el bot i IDBot al grup](#5-afegir-el-bot-i-idbot-al-grup)
6. [Obtenir el Chat ID del grup](#6-obtenir-el-chat-id-del-grup)
7. [Configurar el Media Type a Zabbix](#7-configurar-el-media-type-a-zabbix)
8. [Provar el Media Type](#8-probar-el-media-type)
9. [Verificar la recepció del missatge de prova](#9-verificar-la-recepció-del-missatge-de-prova)
10. [Activar el Media Type a la llista](#10-activar-el-media-type-a-la-llista)
11. [Configurar el medi a l'usuari](#11-configurar-el-medi-a-lusuari)
12. [Afegir Telegram com a nou medi](#12-afegir-telegram-com-a-nou-medi)
13. [Verificar els medis de l'usuari](#13-verificar-els-medis-de-lusuari)
14. [Crear l'acció de trigger](#14-crear-lacció-de-trigger)
15. [Configurar les operacions de l'acció](#15-configurar-les-operacions-de-lacció)
16. [Verificar l'acció creada](#16-verificar-lacció-creada)
17. [Comprovar problemes actius a Zabbix](#17-comprovar-problemes-actius-a-zabbix)
18. [Rebre alertes al grup de Telegram](#18-rebre-alertes-al-grup-de-telegram)

---

## 1. Crear el bot de Telegram amb BotFather

Cerca **@BotFather** a Telegram (compte verificat amb el tick blau) i fes clic a **START** per iniciar la conversa.

![Cercar BotFather a Telegram](img/gmail/T1.png)

> BotFather és el bot oficial de Telegram per crear i gestionar bots. Cal seleccionar el compte verificat `@BotFather`.

---

## 2. Obtenir el token del bot

Un cop iniciat BotFather, envia `/newbot`, tria un **nom** per al bot (ex: `zabbix_notificationbot`) i un **username** que acabi en `_bot` (ex: `aos_zabbix_bot`). BotFather retornarà el **token HTTP API** necessari per a la integració.

![Creació del bot i obtenció del token](img/gmail/T2.png)

> ⚠️ Guarda el token de forma segura. En aquest exemple: `8783643633:AAHRXCVF-h0i9gU0mRoXbgpp0eqvXmZm9D8`

---

## 3. Cercar i iniciar el bot creat

Cerca el bot pel seu username (`aos_zabbix_bot`) i fes clic a **START** per activar-lo.

![Cercar i iniciar el bot nou](img/gmail/T3.png)

---

## 4. Crear el grup de notificacions

Crea un nou grup de Telegram anomenat **`zabbix_notification`**. Aquest grup rebrà totes les alertes de Zabbix.

![Grup zabbix_notification creat](img/gmail/T4.png)

> Telegram confirma la creació del grup i informa que pot tenir fins a 200.000 membres, historial persistent i administradors amb rols diferenciats.

---

## 5. Afegir el bot i IDBot al grup

Des de la configuració del grup, afegeix el bot creat (`zabbix_notificationbot`) i també **@IDBot** (necessari per obtenir el Chat ID del grup).

![Membres del grup amb el bot i IDBot afegits](img/gmail/T5.png)

> El grup ara té 3 membres: l'usuari propietari, `zabbix_notificationbot` i `IDBot`.

---

## 6. Obtenir el Chat ID del grup

Dins el grup, envia la comanda `/getgroupid@myidbot`. IDBot respondrà amb el **Chat ID** del grup (en format negatiu per a grups).

![Obtenció del Chat ID del grup](img/gmail/T6.png)

> En aquest exemple el Chat ID és: **`-5254895121`**. Cal el signe negatiu.

---

## 7. Configurar el Media Type a Zabbix

A Zabbix, ves a **Alertes → Tipus de medis** i obre el tipus **Telegram** (Webhook). Omple els paràmetres:

- `api_chat_id`: el Chat ID del grup (`-5254895121`)
- `api_token`: el token del bot
- `api_parse_mode`: mode de formatació del missatge

![Configuració del Media Type Telegram a Zabbix](img/gmail/T7.png)

---

## 8. Probar el Media Type

Des del formulari del Media Type, fes clic a **Probar** i omple els camps de prova (per exemple, `alert_message: Hola Telegram`). Si la configuració és correcta, apareixerà el missatge **"Prueba de tipo de medio exitosa"**.

![Prova del Media Type amb resultat exitós](img/gmail/T8.png)

---

## 9. Verificar la recepció del missatge de prova

Comprova al grup de Telegram que el bot ha enviat correctament el missatge de prova.

![Missatge de prova rebut al grup de Telegram](img/gmail/T9.png)

> El bot `zabbix_notificationbot` ha enviat el missatge "Test / Hola Telegram" al grup, confirmant que la integració funciona.

---

## 10. Activar el Media Type a la llista

A la llista de **Tipus de medis**, confirma que **Telegram** apareix amb l'estat **Activado**.

![Llista de Media Types amb Telegram activat](img/gmail/T10.png)

---

## 11. Configurar el medi a l'usuari

Ves a **Usuaris → Usuaris**, obre l'usuari administrador i accedeix a la pestanya **Medio**. Fes clic a **Agregar** per afegir Telegram com a medi de notificació.

![Pestanya Medio de l'usuari administrador](img/gmail/T11.png)

---

## 12. Afegir Telegram com a nou medi

Selecciona el tipus **Telegram**, introdueix el Chat ID (`-5254895121`) al camp **Enviar a**, configura l'horari d'activitat i marca les gravetatss desitjades (Promedio, Alta, Crítica).

![Formulari de nou medi Telegram per a l'usuari](img/gmail/T12.png)

---

## 13. Verificar els medis de l'usuari

Confirma que l'usuari té ara dos medis configurats: **Email (HTML)** i **Telegram**, ambdós actius.

![Llista de medis de l'usuari amb Email i Telegram](img/gmail/T13.png)

---

## 14. Crear l'acció de trigger

Ves a **Alertes → Accions → Acciones de iniciador** i fes clic a **Crear acción**. Posa-li el nom `Trigger to Telegram` i afegeix la condició: *Gravedad del iniciador es mayor o igual Alta*.

![Creació de l'acció Trigger to Telegram](img/gmail/T14.png)

---

## 15. Configurar les operacions de l'acció

A la pestanya **Operaciones**, afegeix tres operacions d'enviament de missatge a l'usuari Admin via Telegram:

- **Operació** (problema detectat): envia missatge immediatament
- **Operació de recuperació**: envia missatge quan el problema es resol
- **Operació d'actualització**: envia missatge en cas d'actualització

![Operacions de l'acció configurades](img/gmail/T15.png)

---

## 16. Verificar l'acció creada

Comprova a la llista d'**Acciones de iniciador** que `Trigger to Telegram` apareix activa, amb la condició i les operacions correctes.

![Llista d'accions amb Trigger to Telegram activa](img/gmail/T16.png)

---

## 17. Comprovar problemes actius a Zabbix

Al tauler de **Problemes** de Zabbix es visualitzen els incidents actius detectats (per exemple, agent no disponible, servei aturat, paquets instal·lats canviats).

![Tauler de problemes actius a Zabbix](img/gmail/T17.png)

---

## 18. Rebre alertes al grup de Telegram

Quan Zabbix detecta un problema de gravetat Alta o superior, el bot envia automàticament un missatge al grup `zabbix_notification` amb tota la informació de l'alerta.

![Alertes de Zabbix rebudes al grup de Telegram](img/gmail/T18.png)

> Cada missatge inclou: nom del problema, data i hora d'inici, host afectat, severitat, dades operacionals i ID del problema original.

---

## Resum del flux

```
BotFather (Telegram)
    └─► Crea bot + token
            └─► Grup zabbix_notification + Chat ID
                    └─► Zabbix Media Type (Webhook Telegram)
                            └─► Medi d'usuari configurat
                                    └─► Acció de trigger activa
                                            └─► Alertes automàtiques al grup ✅
```

---

## Dades de referència

| Paràmetre | Valor |
|-----------|-------|
| Bot username | `@aos_zabbix_bot` |
| Nom del bot | `zabbix_notificationbot` |
| Nom del grup | `zabbix_notification` |
| Chat ID del grup | `-5254895121` |
| Gravetat mínima d'alerta | Alta |
| Horari d'activitat | 1-7, 00:00-24:00 |
