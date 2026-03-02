# **Projecte de Monitorització de Xarxes (Zabbix, Cacti, Nagios)**

## **1. Introducció a la monitorització de xarxa**

La monitorització de xarxa consisteix en el conjunt de tècniques i eines que permeten supervisar de manera contínua l’estat, el rendiment i la disponibilitat dels dispositius i serveis d’una infraestructura. Tal com indica el document:

> “La monitorització de xarxa és el conjunt de tècniques i eines utilitzades per supervisar de manera contínua l'estat, el rendiment i la disponibilitat dels dispositius i serveis...” 

### **Conceptes bàsics**
- **Disponibilitat**: temps en què un sistema està operatiu.
- **Rendiment**: inclou latència, ample de banda i pèrdua de paquets.
- **Alertes**: notificacions automàtiques davant anomalies.
- **Monitorització activa**: envia peticions (ping, SNMP).
- **Monitorització passiva**: rep informació dels dispositius (logs, esdeveniments).
- **SNMP**: protocol clau per obtenir dades de dispositius de xarxa.

---

## **2. Importància de la monitorització en entorns informàtics**

La monitorització és essencial per garantir estabilitat, seguretat i bon rendiment. Les organitzacions depenen dels seus sistemes per operar, i qualsevol interrupció pot afectar greument el negoci.

El document destaca:

> “La importància de la monitorització rau [...] en la seva capacitat per detectar incidències de manera anticipada.” 

### **Beneficis principals**
- **Detecció precoç d’incidències**.
- **Millora en la gestió de recursos** mitjançant dades històriques.
- **Contribució a la seguretat** detectant comportaments anòmals.
- **Optimització i planificació d’infraestructura**.

---

## **3. Eines de monitorització i característiques**

El document analitza diverses eines, destacant-ne les diferències.

### **Nagios**
- Codi obert.
- Molt configurable.
- Interfície bàsica.
- Escalabilitat alta però manual.
- No disposa d’agents propis.

### **Zabbix**
- Codi obert.
- Monitorització integral (xarxa, servidors, aplicacions).
- Interfície moderna.
- Alertes avançades.
- Agents propis.
- Descobriment automàtic.

### **Cacti**
- Codi obert.
- Especialitzat en gràfics de rendiment.
- Configuració senzilla.
- No orientat a alertes avançades.

El document resumeix:

> “Zabbix integra monitorització de servidors, xarxa, alertes, gràfics i descobriment automàtic en una sola plataforma...” 

---

## **4. Comparativa d’eines**

### **Taula resum**

| Característica | Nagios | Zabbix | Cacti |
|----------------|--------|--------|--------|
| Tipus de llicència | Codi obert | Codi obert | Codi obert |
| Enfocament | Serveis i hosts | Monitorització integral | Gràfics de rendiment |
| Interfície web | Bàsica | Moderna | Senzilla |
| Alertes | Molt configurable | Avançades | Limitades |
| Gràfics | Requereix complements | Integrats | Molt potents |
| Descobriment automàtic | Limitat | Sí | No |
| Agents | No | Sí | No |
| Dificultat | Mitjana/Alta | Mitjana | Baixa |
| Escalabilitat | Alta | Molt alta | Mitjana |

---

## **5. Anàlisi de requisits del projecte**

Els requisits identificats inclouen:

- Monitorització de servidors Linux.
- Supervisió de serveis (Apache, MySQL, SSH...).
- Control de CPU, memòria i disc.
- Monitorització de xarxa (ping, ports, trànsit).
- Alertes configurables.
- Interfície web centralitzada.
- Escalabilitat.
- Solució de codi obert.

---

## **6. Valoració de les eines segons requisits**

- **Nagios**: potent però menys intuïtiu i més manual.
- **Cacti**: excel·lent per gràfics, però limitat en alertes i monitorització integral.
- **Zabbix**: compleix tots els requisits i ofereix una solució completa.

---

## **7. Selecció de l’eina: Zabbix**

El document conclou que **Zabbix és l’eina més adequada** per al projecte.

> “Després de l’anàlisi, l’eina més adequada per a l’escenari del projecte és Zabbix.” 

### **Motivacions principals**
- Compleix tots els requisits funcionals.
- Monitorització activa i passiva.
- Agents propis amb mètriques detallades.
- Gràfics i informes integrats.
- Escalabilitat elevada.
- Codi obert i adequat per a entorns formatius.

---

## **8. Fonts utilitzades**
- Documentació oficial de SNMP (RFC 1157, RFC 3411–3418)
- Documentació oficial de Nagios
- Documentació oficial de Zabbix
- Apunts del mòdul de Planificació i Administració de Xarxes del CFGS ASIX

---
