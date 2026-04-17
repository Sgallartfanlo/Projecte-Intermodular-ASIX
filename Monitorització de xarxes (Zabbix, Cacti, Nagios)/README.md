# Projecte: Monitorització de Xarxes

## Zabbix · Cacti · Nagios

**Autors:**
Oleguer Esteo Martínez
Sergi Gallart Fanlo
Àlex Marqués Comas

---

## 1. Introducció a la Monitorització de Xarxa

La monitorització de xarxa consisteix en un conjunt de tècniques i eines que permeten supervisar de manera contínua l’estat, el rendiment i la disponibilitat dels dispositius i serveis d’una infraestructura informàtica.

### 1.1 Conceptes clau

* **Objectiu:** Garantir el correcte funcionament de routers, switches, servidors i serveis web.
* **Disponibilitat:** Percentatge de temps que un sistema està operatiu i accessible.
* **Rendiment:** Es mesura mitjançant latència, ample de banda i pèrdua de paquets.
* **Alertes:** Notificacions automàtiques quan es detecten anomalies.

### 1.2 Tipus de monitorització

* **Activa:** Envia peticions als dispositius (ping, consultes SNMP, etc.).
* **Passiva:** Es basa en la recepció de logs o esdeveniments generats pels equips.

### 1.3 Protocols més utilitzats

* **SNMP:** Recollida de dades (CPU, memòria i trànsit).
* **ICMP:** Comprovació de connectivitat.
* **Agents:** Programari instal·lat als equips per obtenir dades detallades.

---

## 2. Importància en Entorns Informàtics

La monitorització és essencial per garantir l’estabilitat, el rendiment i la seguretat dels sistemes informàtics.

### 2.1 Beneficis principals

* **Detecció anticipada:** Permet identificar problemes abans que esdevinguin crítics.
* **Gestió de recursos:** Facilita l’optimització de la infraestructura i la reducció de costos.
* **Seguretat:** Actua com a sistema d’alerta davant comportaments anòmals o accessos sospitosos.

---

## 3. Comparativa d’Eines

A continuació es mostra una comparativa entre tres eines de monitorització de codi obert:

| Característica | Nagios               | Zabbix                  | Cacti                  |
| -------------- | -------------------- | ----------------------- | ---------------------- |
| Enfocament     | Serveis i hosts      | Monitorització integral | Gràfiques de rendiment |
| Interfície web | Bàsica               | Moderna i intuïtiva     | Orientada a gràfics    |
| Gràfics        | Mitjançant plugins   | Integrats               | Molt potents           |
| Alertes        | Molt configurables   | Avançades i flexibles   | Limitades              |
| Configuració   | Mitjana/Alta         | Mitjana                 | Baixa                  |
| Agents propis  | No (plugins externs) | Sí                      | No                     |
| Escalabilitat  | Alta (manual)        | Molt alta               | Mitjana                |

---

## 4. Selecció de l’Eina: Zabbix

Després de l’anàlisi comparativa, s’ha seleccionat Zabbix com l’eina més adequada per al projecte.

### 4.1 Requisits del projecte

* Monitorització de servidors Linux i serveis (Apache, MySQL, SSH).
* Control de recursos (CPU, memòria, disc).
* Monitorització de xarxa bàsica.
* Sistema d’alertes configurable.
* Interfície web centralitzada.
* Solució de codi obert sense cost de llicència.

---

### 4.2 Justificació de l’elecció

1. **Monitorització integral**
   Permet supervisar dispositius de xarxa i servidors en una única plataforma.

2. **Agents propis**
   Faciliten l’obtenció de mètriques detallades del sistema.

3. **Gestió proactiva**
   Sistema d’alertes avançat amb llindars personalitzables.

4. **Escalabilitat i visualització**
   Inclou gràfics i informes natius i s’adapta al creixement de la infraestructura.

---

## 5. Conclusions

Zabbix destaca com una solució completa, escalable i eficient per a la monitorització d’infraestructures, oferint una combinació equilibrada de funcionalitats, facilitat d’ús i capacitat d’expansió.
