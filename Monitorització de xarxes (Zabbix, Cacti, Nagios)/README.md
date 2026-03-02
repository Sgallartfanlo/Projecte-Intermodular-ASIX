Aquest és un resum estructurat del projecte de monitorització de xarxes basat en el document proporcionat:
Projecte: Monitorització de Xarxes (Zabbix, Cacti, Nagios)
Autors: Oleguer Esteo Martínez, Sergi Gallart Fanlo i Àlex Marqués Comas.
1. Introducció a la Monitorització de Xarxa
La monitorització de xarxa consisteix en un conjunt de tècniques i eines per supervisar contínuament l'estat, el rendiment i la disponibilitat dels dispositius i serveis d'una infraestructura.
Conceptes Claus
 * Objectiu: Garantir que routers, switches, servidors i serveis web funcionin correctament.
 * Disponibilitat: Percentatge de temps que un sistema està operatiu i accessible.
 * Rendiment: Mesurat a través de la latència, l'ample de banda i la pèrdua de paquets.
 * Alertes: Notificacions automàtiques generades en detectar anomalies.
 * Tipus de monitorització:
   * Activa: Envia peticions (ping, consultes SNMP) als dispositius.
   * Passiva: Es basa en la recepció de logs o esdeveniments generats pels equips.
 * Protocols comuns: SNMP (per recollir dades de CPU, memòria i trànsit), ICMP (connectivitat) i agents específics.
2. Importància en Entorns Informàtics
La monitorització és vital per l'estabilitat i seguretat de les organitzacions. Els seus beneficis principals inclouen:
 * Detecció anticipada: Identifica comportaments anòmals abans que esdevinguin errors crítics.
 * Gestió de recursos: Ajuda a dimensionar la infraestructura i optimitzar costos analitzant tendències d'ús.
 * Seguretat: Actua com a sistema d'alerta primerenca davant increments inesperats de trànsit o intents d'accés fallits.
3. Comparativa d'Eines
El document analitza tres de les solucions de codi obert més rellevants:
| Característica | Nagios | Zabbix | Cacti |
|---|---|---|---|
| Enfocament | Serveis i hosts | Integral (xarxa, servidors, apps) | Gràfiques de rendiment |
| Interfície Web | Bàsica | Moderna i intuïtiva | Orientada a gràfics |
| Gràfics | Requereix complements | Integrats de sèrie | Molt potent |
| Alertes | Molt configurable | Avançat i flexible | Limitades |
| Configuració | Mitjana/Alta | Mitjana | Baixa |
| Agents propis | No (plugins externs) | Sí | No |
| Escalabilitat | Alta (manual) | Molt alta | Mitjana |
4. Selecció de l'Eina: Zabbix
L'equip ha seleccionat Zabbix com l'eina més adequada per al projecte.
Requisits del Projecte
 * Monitorització de servidors Linux i serveis (Apache, MySQL, SSH).
 * Control de recursos (CPU, memòria, disc) i xarxa bàsica.
 * Sistema d'alertes configurable i interfície web centralitzada.
 * Solució de codi obert sense cost de llicència.
Justificació de l'elecció
 * Monitorització integral: Combina dispositius de xarxa i servidors en una sola plataforma.
 * Agents propis: Permeten obtenir mètriques detallades de l'estat del sistema.
 * Gestió proactiva: El seu sistema d'alertes avançat permet definir llindars personalitzats.
 * Escalabilitat i Visualització: Ofereix gràfics i informes natius i pot créixer segons la infraestructura ho requereixi.
Voldries que t'ajudi a detallar com configurar algun dels protocols esmentats, com l'SNMP, dins de Zabbix?
