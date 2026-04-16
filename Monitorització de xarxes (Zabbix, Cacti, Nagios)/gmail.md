# Configuració d'Alertes de Gmail a Zabbix

Guia completa per configurar notificacions d'alertes de **Zabbix** via **Gmail** usando SMTP. Aquesta documentació inclou tots els passos necessaris des de la configuració de Google Account fins a la verificació final de les alertes.

---

## Índex
1. [Introducció](#introducció)
2. [Fase 1: Configuració de Google Account](#fase-1-configuració-de-google-account)
3. [Fase 2: Configuració de Zabbix - Tipos de Medios](#fase-2-configuració-de-zabbix---tipos-de-medios)
4. [Fase 3: Plantillas de Mensaje](#fase-3-plantillas-de-mensaje)
5. [Fase 4: Configuración de Acciones](#fase-4-configuración-de-acciones)
6. [Fase 5: Usuarios y Permisos](#fase-5-usuarios-y-permisos)
7. [Fase 6: Verificación y Resultados](#fase-6-verificación-y-resultados)

---

## Introducció

Aquesta guia explica com configurar **Zabbix 7.4.7** per enviar alertes via correo electrònic usando l'SMTP de Gmail. El procés requereix:
- Una compte de Google amb autenticació de doble factor
- Una contrasenya d'aplicació de Google
- Configuració correcta del servidor SMTP de Gmail
- Creació de tipus de medios, plantillas i acciones a Zabbix

**Avantatges:**
- Notificacions en temps real
- Fàcil configuració
- Seguretat via OAuth i contrasenyes d'aplicació
- Compatible amb Gmail gratuït

---

## Fase 1: Configuració de Google Account

### Pas 1: Accedint a les Contrasenyes d'Aplicació de Google

![Google Account - Contrasenyes d'Aplicació](img/gmail/GM3.png)
**Imatge 1:** Pantalla de Contrasenyes d'Aplicació de Google. Aquí es mostren totes les contrasenyes generades per a aplicacions específiques.

- Accedint a [Google Account](https://myaccount.google.com)
- Navegant a **Seguretat** → **Contrasenyes d'aplicació**
- Seleccionant **Mail** i **Windows** (o el teu sistema operatiu)
- Google generarà una contrasenya única per a l'aplicació

### Pas 2: Aplicació Gmail (Zabbix)

![Google Account - Password per Zabbix](img/gmail/GM3.png)
**Imatge 2:** La contrasenya generada per a l'aplicació Zabbix es mostra en aquesta pantalla. Guardant aquesta contrasenya de forma segura.

La contrasenya generada té aquest format: `xxxx xxxx xxxx xxxx` (16 caràcters)

**Important:** Aquesta contrasenya s'usarà a la configuració SMTP de Zabbix.

---

## Fase 2: Configuració de Zabbix - Tipos de Medios

### Pas 1: Accedint a Tipos de Medios

![Zabbix - Tipos de Medios](img/gmail/GM1.png)
**Imatge 3:** Llista de Tipos de Medios en Zabbix. Es mostren els tipus de notificació disponibles com Webhook, Discord, i Email.

Camí: **Alertas** → **Tipos de medios**

### Pas 2: Creant Nuevo Tipo de Medio - Notificacions Gmail

![Zabbix - Crear Notificacions Gmail](img/gmail/GM2.png)
**Imatge 4:** Configuració detallada del tipo de medio "Notificacions Gmail" amb els paràmetres SMTP necessaris:

| Paràmetre | Valor |
|-----------|-------|
| **Nombre** | Notificacions Gmail |
| **Tipo** | Correo electrònico |
| **Proveedor SMTP** | Generic SMTP |
| **Servidor SMTP** | smtp.gmail.com |
| **Puerto SMTP** | 587 |
| **Correo electrònico** | s.gallart@sapalomera.cat |
| **SMTP helo** | gmail.com |
| **Seguridad conexión** | STARTTLS |
| **Autenticación** | Usuario y contraseña |
| **Usuario** | s.gallart@sapalomera.cat |
| **Contraseña** | [Contrasenya d'aplicació de Google] |
| **Formato de mensaje** | HTML |

### Pas 3: Verificant Tipo de Medio Activado

![Zabbix - Tipo de Medio Activado](img/gmail/GM7.png)
**Imatge 5:** Confirmació que el tipo de medio "Notificacions Gmail" està activado i correctament configurado. Es mostra el servidor SMTP i altres paràmetres essencials.

- El estado deve ser **Activado**
- Tots els paràmetres devon ser correctes
- Es pot veure el "Servidor SMTP" confirmant la configuració

### Pas 4: Provant el Tipo de Medio

![Zabbix - Probar Notificaciones Gmail](img/gmail/GM4.png)
**Imatge 6:** Diàleg per provar el tipo de medio. Aquí es pot enviar un email de prova per verificar que la configuració funciona correctament.

- Fent clic al botó **"Probar"**
- Completant els camps:
  - **Enviar a:** Correu destí (p.ex. s.gallart@sapalomera.cat)
  - **Título:** "Prova assumpte"
  - **Mensaje:** "Este es el mensaje de prueba de Zabbix"

---

## Fase 3: Plantillas de Mensaje

### Pas 1: Accedint a Plantillas de Mensajes

![Zabbix - Plantillas de Mensajes](img/gmail/GM8.png)
**Imatge 7:** Llista de Plantillas de Mensaje disponibles. Aquestes plantillas defineixen el format del contingut dels emails d'alerta.

Camí: **Alertas** → **Tipos de medios** → **Notificacions Gmail** → **Plantillas de mensajes**

### Pas 2: Plantillas Disponibles

Algunes plantillas comunes inclouen:

| Tipo | Descripció |
|------|-----------|
| **Problema** | Plantilla per a problemes detectats |
| **Recuperación del problema** | Plantilla per a recuperació de problemes |
| **Actualización del problema** | Plantilla per a actualitzacions d'estat |
| **Descubrimiento** | Plantilla per a descobriments de nous equips |
| **Autoregistro** | Plantilla per a registres automàtics |

---

## Fase 4: Configuración de Acciones

### Pas 1: Accedint a Acciones

![Zabbix - Acciones de Iniciador](img/gmail/GM9.png)
**Imatge 8:** Llista de Acciones de Iniciador en Zabbix. Aquestes acciones defineixen que fer quan es detecta un problema.

Camí: **Alertas** → **Acciones** → **Acciones de iniciador**

### Pas 2: Creant Nova Acción

![Zabbix - Nova Acción](img/gmail/GM10.png)
**Imatge 9:** Pantalla de creació d'una nova acció. Es configura el nom i les condicions per a la declanxació de l'acció.

- **Nombre:** "Report problems to Zabbix administrators"
- **Condiciones:** Es pot deixar buit o afegir condicions específiques

### Pas 3: Operacions de la Acción

![Zabbix - Operacions Detallades](img/gmail/GM13.png)
**Imatge 10:** Configuració de les Operaciones de la acció. S'especifica la duració predeterminada i les operacions a executar.

| Configuració | Valor |
|-------------|-------|
| **Duración predeterminada del paso de operación** | 1h |

### Pas 4: Configurant Envío de Mensaje

![Zabbix - Detalles de la Operación](img/gmail/GM14.png)
**Imatge 11:** Configuració detallada de l'operació de envío de missatge:

- **Operación:** "Enviar mensaje"
- **Enviar a grupos de usuarios:** [Selecciona grup]
- **Enviar a usuarios:** Admin (Zabbix Administrator)
- **Enviar a tipo de medio:** Email (HTML)
- **Mensaje personalizado:** [desmarcado]

### Pas 5: Operaciones de Recuperación

![Zabbix - Acciones Avanzadas](img/gmail/GM15.png)
**Imatge 12:** Configuració d'operacions adicionals:

**Operaciones:**
- "Enviar mensaje a grupo de usuarios: Zabbix administrators a través de todos los medios"

**Operaciones de recuperación:**
- "Notificar a todos los involucrados" - via Email (HTML)

**Operaciones de actualización:**
- "Enviar mensaje a usuarios: Admin (Zabbix Administrator) a través de Email (HTML)"

**Opciones adicionales:**
- Pausant operaciones por problemas de síntomas
- Pausant operaciones para problemas suprimidos
- Notificant sobre escalamientos cancelados

---

## Fase 5: Usuarios y Permisos

### Pas 1: Accedint a Usuarios

![Zabbix - Gestión de Usuarios](img/gmail/GM16.png)
**Imatge 13:** Llista de Usuarios en Zabbix. Es mostra la taula amb tots els usuaris registrats:

| Usuario | Nombre | Rol | Grupos | Estado |
|---------|--------|-----|--------|--------|
| **Admin** | Zabbix | Administrator | Super admin | Activado |
| guest | - | Guest role | Guests | Desactivado |
| zabbix_monitor | - | Super admin role | - | Activado |
| zabbix_suport | - | User role | - | Activado |

### Pas 2: Configurant Medios del Usuario

![Zabbix - Medios del Usuario](img/gmail/GM17.png)
**Imatge 14:** Configuració de Medios del usuario. Aquí es defineix com l'usuari rebà les notificacions.

Camí: **Administración** → **Usuarios** → [Selecciona usuario] → **Medio**

- Fent clic a **"Agregar"**

### Pas 3: Afegint Nuevo Medio al Usuario

![Zabbix - Nuevo Medio para Usuario](img/gmail/GM18.png)
**Imatge 15:** Configuració d'un nou meio per al usuario:

| Camp | Valor |
|------|-------|
| **Tipo** | Email (HTML) |
| **Enviar a** | s.gallart@sapalomera.cat |
| **Cuándo está activo** | 1-7,00:00-24:00 |
| **Utilizar si la gravedad** | Informativa, Advertencia, Promedio, Alta, Crítica |
| **Activado** | Sí |

### Pas 4: Confirmació de Medio Asignat

![Zabbix - Medio Asignado al Usuario](img/gmail/GM19.png)
**Imatge 16:** Confirmació que el meio ha estat correctament asignat al usuari.

Es mostra:
- **Tipo:** Email (HTML)
- **Enviar a:** s.gallart@sapalomera.cat
- **Cuándo está activo:** 1-7,00:00-24:00
- **Severidad:** N | I | A | P | A | C (Totes seleccionades)
- **Estado:** Activado

---

## Fase 6: Verificación y Resultados

### Pas 1: Email de Prueba Rebut

![Gmail - Email de Prueba Recibido](img/gmail/GM5.png)
**Imatge 17:** Email de prueba rebut en Gmail. Mostra el missatge de prova enviat desde Zabbix:

- **De:** s.gallart@sapalomera.cat
- **Asunto:** "Prova assumpte"
- **Contenido:** "Este es el mensaje de prueba de Zabbix"

### Pas 2: Monitoritzant Problemes Detectats

![Zabbix - Problemas Detectados](img/gmail/GM21.png)
**Imatge 18:** Pantalla de Problemas en Zabbix mostrando els events detectats:

- **Problema 1:** "Windows: Active checks are not available"
  - Severity: Alta (rojo)
  - Duration: 7s
  - Host: DC01

- **Problema 2:** "Windows: Host has been restarted"
  - Severity: Media (amarillo)
  - Duration: 9m 44s
  - Host: DC01

### Pas 3: Email amb Detalls del Problema

![Gmail - Detalles del Problema](img/gmail/GM22.png)
**Imatge 19:** Encabezado del email a la bandeja de entrada de Gmail.

### Pas 4: Contingut del Email d'Alerta

![Gmail - Contenido Completo de la Alerta](img/gmail/GM23.png)
**Imatge 20:** Email d'alerta rebut amb informació detallada del problema:

```
Problem: Windows: Active checks are not available
Problem started at 20:05:19 on 2026.04.07
Problem name: Windows: Active checks are not available
Host: DC01
Severity: High
Operational data: Current state: not available (2)
Original problem ID: 808
```

---

## Checklist de Configuració

- Creant contrasenya d'aplicació a Google Account
- Configurant tipo de medio "Notificaciones Gmail" a Zabbix
  - Servidor SMTP: smtp.gmail.com
  - Puerto: 587
  - Seguridad: STARTTLS
  - Autenticación: Usuario y contraseña
- Afegint plantillas de mensaje
- Creant acció de iniciador
- Assignant usuario al grup de notificaciones
- Configurant medio de usuario (Email HTML)
- Provant tipo de medio
- Verificant recepció de emails de prova
- Monitoritzant que els problemes generem alertes per email

---

## Configuració de Paràmetres SMTP

### Gmail SMTP:
```
Servidor: smtp.gmail.com
Puerto: 587
Conexión: STARTTLS
Usuario: tu_email@gmail.com
Contraseña: xxxx xxxx xxxx xxxx (generada desde Google Account)
```

### Alternativas:
Si necessites usar OAuth en lloc de contrasenya d'aplicació, consulta la documentació oficial de Zabbix.

---

## Recursos Útils

- [Documentació oficial de Zabbix](https://www.zabbix.com/documentation/)
- [Gmail SMTP Configuration](https://support.google.com/mail/answer/185833)
- [Google App Passwords](https://support.google.com/accounts/answer/185833)
- [Zabbix Email Notifications](https://www.zabbix.com/documentation/current/en/manual/config/notifications/media)

---

## Solució de Problemes

### El email no s'envia:
1. Verificant que la contrasenya d'aplicació sigui correcta
2. Assegurant que STARTTLS estigui habilitat
3. Comprovant que el port 587 estigui obert
4. Revisent els logs de Zabbix a `/var/log/zabbix/`

### Els emails arriben a SPAM:
1. Afegint la dirección de Zabbix als contactes
2. Marcant els emails com "No és spam"
3. Configurant registres SPF i DKIM en el teu domini

### Errors d'autenticació:
1. Verificant que hagis habilitat l'autenticació de doble factor a Google
2. Generant una nova contrasenya d'aplicació
3. Assegurant de seleccionar "Mail" i "Windows" correctament

---

## Notas Adicionals

- Aquesta configuració es va provar amb **Zabbix 7.4.7**
- Els correus s'envien únicament durant l'horari configurat (1-7, 00:00-24:00)
- Es poden crear múltiples medios per usuario per a diferents tipus d'alertes
- Les plantillas de missatge es poden personalitzar segons necessitats

---

**Última actualización:** Abril 2026
**Versión de Zabbix:** 7.4.7
**Estado:** Funcional

