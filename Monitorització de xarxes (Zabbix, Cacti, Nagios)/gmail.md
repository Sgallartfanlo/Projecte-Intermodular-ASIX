# Configuració d'Alertes de Gmail a Zabbix

## Fase 1: Configuració de Google Account

### Pas 1: Accedint a les Contrasenyes d'Aplicació de Google

![Compte de Google - Contrasenyes d'Aplicació](img/gmail/GM3.png)
**Imatge 1:** Pantalla de Contrasenyes d'Aplicació de Google. Aquí es mostren totes les contrasenyes generades per a aplicacions específiques.

- Accedint a [Compte de Google](https://myaccount.google.com)
- Navegant a **Seguretat** → **Contrasenyes d'aplicació**
- Seleccionant **Correu** i **Windows** (o el teu sistema operatiu)
- Google generarà una contrasenya única per a l'aplicació

### Pas 2: Aplicació Gmail (Zabbix)

![Compte de Google - Contrasenya per a Zabbix](img/gmail/GM3.png)

**Imatge 2:** La contrasenya generada per a l'aplicació Zabbix es mostra en aquesta pantalla. Guardant aquesta contrasenya de forma segura.

La contrasenya generada té aquest format: `xxxx xxxx xxxx xxxx` (16 caràcters)

**Important:** Aquesta contrasenya s'usarà a la configuració SMTP de Zabbix.

---

## Fase 2: Configuració de Zabbix - Tipus de Mitjans

### Pas 1: Accedint a Tipus de Mitjà

![Zabbix - Tipus de Mitjans](img/gmail/GM1.png)

**Imatge 3:** Llista de Tipus de Mitjans en Zabbix. Es mostren els tipus de notificació disponibles com Webhook, Discord, i Correu.

### Pas 2: Creant Nou Tipus de Medi - Notificacions Gmail

![Zabbix - Crear Notificacions Gmail](img/gmail/GM2.png)
**Imatge 4:** Configuració detallada del tipus de mitjà "Notificacions Gmail" amb els paràmetres SMTP necessaris:

| Paràmetre | Valor |
|-----------|-------|
| **Nom** | Notificacions Gmail |
| **Tipus** | Correu electrònic |
| **Providor SMTP** | SMTP Genèric |
| **Servidor SMTP** | smtp.gmail.com |
| **Port SMTP** | 587 |
| **Correu electrònic** | s.gallart@sapalomera.cat |
| **SMTP helo** | gmail.com |
| **Seguretat connexió** | STARTTLS |
| **Autenticació** | Usuari i contrasenya |
| **Usuari** | s.gallart@sapalomera.cat |
| **Contrasenya** | [Contrasenya d'aplicació de Google] |
| **Format de missatge** | HTML |

### Pas 3: Verificant Tipus de Mitjà Activat

![Zabbix - Tipus de Mitjà Activat](img/gmail/GM7.png)

**Imatge 5:** Confirmació que el tipus de mitjà "Notificacions Gmail" està activat i correctament configurat. Es mostra el servidor SMTP i altres paràmetres essencials.

- L'estat ha de ser **Activat**
- Tots els paràmetres han de ser correctes
- Es pot veure el "Servidor SMTP" confirmant la configuració

### Pas 4: Provant el Tipo de Mitjà

![Zabbix - Provar Notificacions Gmail](img/gmail/GM4.png)
**Imatge 6:** Diàleg per provar el tipus de mitjà. Aquí es pot enviar un correu de prova per verificar que la configuració funciona correctament.

- Fent clic al botó **"Provar"**
- Completant els camps:
  - **Enviar a:** Correu destí (p.ex. s.gallart@sapalomera.cat)
  - **Assumpte:** "Prova assumpte"
  - **Missatge:** "Aquest és el missatge de prova de Zabbix"

---

## Fase 3: Plantilles de Missatge

### Pas 1: Accedint a Plantillas de Missatges

![Zabbix - Plantilles de Missatges](img/gmail/GM8.png)
**Imatge 7:** Llista de Plantilles de Missatge disponibles. Aquestes plantilles defineixen el format del contingut dels correus d'alerta.

### Pas 2: Plantilles Disponibles

Algunes plantilles comunes inclouen:

| Tipus | Descripció |
|------|-----------|
| **Problema** | Plantilla per a problemes detectats |
| **Recuperació del problema** | Plantilla per a recuperació de problemes |
| **Actualització del problema** | Plantilla per a actualitzacions d'estat |
| **Descobriment** | Plantilla per a descobriments de nous equips |
| **Autorregistre** | Plantilla per a registres automàtics |

---

## Fase 4: Configuració d'accions

### Pas 1: Accedint a Accions

![Zabbix - Accions de Disparador](img/gmail/GM9.png)

**Imatge 8:** Llista de Accions de Disparador en Zabbix. Aquestes accions defineixen què fer quan es detecta un problema.

### Pas 2: Creant Nova Acció

![Zabbix - Nova Acció](img/gmail/GM10.png)

**Imatge 9:** Pantalla de creació d'una nova acció. Es configura el nom i les condicions per a la declanxació de l'acció.

- **Nom:** "Reportar problemes als administradors de Zabbix"
- **Condicions:** Es pot deixar buit o afegir condicions específiques

### Pas 3: Operacions de la Acció

![Zabbix - Operacions Detallades](img/gmail/GM13.png)

**Imatge 10:** Configuració de les Operacions de l'acció. S'especifica la durada predeterminada i les operacions a executar.

### Pas 4: Configurant Envío de Mensaje

![Zabbix - Detalls de l'Operació](img/gmail/GM14.png)

**Imatge 11:** Configuració detallada de l'operació d'enviament de missatge:

- **Operació:** "Enviar missatge"
- **Enviar a grups d'usuaris:** [Selecciona grup]
- **Enviar a usuaris:** Admin (Administrador de Zabbix)
- **Enviar a tipus de mitjà:** Correu (HTML)
- **Missatge personalitzat:** [Desmarcat]

### Pas 5: Operaciones de Recuperación

![Zabbix - Accions Avançades](img/gmail/GM15.png)

**Imatge 12:** Configuració d'operacions addicionals:

**Operacions:**
- "Enviar missatge a grup d'usuaris: administradors de Zabbix a través de tots els mitjans"

**Operacions de recuperació:**
- "Notificar a tots els involucrats" - via Correu (HTML)

**Operacions d'actualització:**
- "Enviar missatge a usuaris: Admin (Administrador de Zabbix) a través de Correu (HTML)"

**Opcions addicionals:**
- Pausant operacions per problemes de símptomes
- Pausant operacions per problemes suprimits
- Notificant sobre escalaments cancel·lats

---

## Fase 5: Usuaris y Permisos

### Pas 1: Accedint a Usuaris

![Zabbix - Gestió d'Usuaris](img/gmail/GM16.png)

**Imatge 13:** Llista d'Usuaris en Zabbix. Es mostra la taula amb tots els usuaris registrats:

| Usuari | Nom | Rol | Grups | Estat |
|---------|--------|-----|--------|--------|
| **Admin** | Zabbix | Administrador | Super administrador | Activat |
| guest | - | Rol d'invitat | Convidats | Desactivat |
| zabbix_monitor | - | Rol super administrador | - | Activat |
| zabbix_suport | - | Rol d'usuari | - | Activat |

### Pas 2: Configurant Mitjàs del Usuari

![Zabbix - Mitjans de l'Usuari](img/gmail/GM17.png)

**Imatge 14:** Configuració de Mitjans de l'usuari. Aquí es defineix com l'usuari rebrà les notificacions.

- Fent clic a **"Afegir"**

### Pas 3: Afegint Nou Mitjà al Usuari

![Zabbix - Nou Mitjà per a l'Usuari](img/gmail/GM18.png)

**Imatge 15:** Configuració d'un nou mitjà per a l'usuari:

### Pas 4: Confirmació de Mitjà Asignat

![Zabbix - Mitjà Assignat a l'Usuari](img/gmail/GM19.png)

**Imatge 16:** Confirmació que el mitjà ha estat correctament assignat a l'usuari.
---

## Fase 6: Verificación y Resultados

### Pas 1: Email de Prova Rebut

![Gmail - Correu de Prova Rebut](img/gmail/GM5.png)
**Imatge 17:** Correu de prova rebut en Gmail. Mostra el missatge de prova enviat des de Zabbix:

- **De:** s.gallart@sapalomera.cat
- **Assumpte:** "Prova assumpte"
- **Contingut:** "Aquest és el missatge de prova de Zabbix"

### Pas 2: Monitoritzant Problemes Detectats

![Zabbix - Problemes Detectats](img/gmail/GM21.png)
**Imatge 18:** Pantalla de Problemes en Zabbix mostrant els events detectats:

- **Problema 1:** "Windows: Les comprovacions actives no estan disponibles"
  - Severitat: Alta (vermell)
  - Durada: 7s
  - Host: DC01

- **Problema 2:** "Windows: L'host ha estat reiniciat"
  - Severitat: Mitja (groc)
  - Durada: 9m 44s
  - Host: DC01

### Pas 3: Email amb Detalls del Problema

![Gmail - Detalls del Problema](img/gmail/GM22.png)

**Imatge 19:** Encapçalat del correu a la safata d'entrada de Gmail.

### Pas 4: Contingut del Correu d'Alerta

![Gmail - Contingut Complet de l'Alerta](img/gmail/GM23.png)

**Imatge 20:** Correu d'alerta rebut amb informació detallada del problema:

```
Problema: Windows: Les comprovacions actives no estan disponibles
Problema iniciat a les 20:05:19 el 2026.04.07
Nom del problema: Windows: Les comprovacions actives no estan disponibles
Host: DC01
Severitat: Alta
Dades operacionals: Estat actual: no disponible (2)
ID original del problema: 808
```

---

## Recursos Útils

- [Documentació oficial de Zabbix](https://www.zabbix.com/documentation/)
- [Configuració SMTP de Gmail](https://support.google.com/mail/answer/185833)
- [Contrasenyes d'Aplicació de Google](https://support.google.com/accounts/answer/185833)
- [Notificacions de Correu de Zabbix](https://www.zabbix.com/documentation/current/en/manual/config/notifications/media)

---
