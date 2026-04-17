# Documentacio de Configuracio de Mapes en Zabbix

Aquest repositori conté la guia visual i tècnica per a la creació, configuració i desplegament de mapes de xarxa en l'entorn de monitoratge Zabbix. Els mapes permeten una visualització jeràrquica i en temps real de l'estat dels serveis i la infraestructura.

---

## Detall de les Fases de Configuracio

A continuació es descriuen els passos realitzats, vinculats a les captures de pantalla emmagatzemades a la ruta `img/gmail/`.

### 1. Seleccio del Modul de Visualitzacio
Ruta de la imatge: `img/gmail/MP1.png`
En aquesta fase s'accedeix al menú lateral de Zabbix, concretament a Monitoring > Maps. Aquest és el punt de partida on es llisten tots els mapes existents i on es defineixen les visualitzacions globals. És fonamental tenir els permisos d'usuari adequats (Zabbix Admin o Super Admin) per gestionar aquestes vistes.

### 2. Definicio de Paràmetres del Mapa
Ruta de la imatge: `img/gmail/MP2.png`
Configuració de les propietats bàsiques del mapa (Map properties). En aquest punt es defineix:
- El nom del mapa (procurant seguir una nomenclatura clara).
- Les dimensions en píxels (Width/Height) per adaptar-lo a les pantalles de monitoratge (NOC).
- El fons del mapa (Background image), que pot ser un plànol d'oficina o un mapa geogràfic.
- La gestió de les icones i com es mostraran els noms dels elements.

### 3. Disseny de la Topologia i Elements
Ruta de la imatge: `img/gmail/MP3.png`
Dins de l'editor del mapa (Constructor), s'afegeixen els elements (Map elements). Aquest pas inclou:
- L'addició de hosts específics, grups de hosts o altres mapes.
- El canvi d'icones segons el tipus de dispositiu (servidors, routers, firewalls).
- L'alineació dels elements per mantenir una estètica neta i professional.

### 4. Configuracio d Enllacos i Triggers
Ruta de la imatge: `img/gmail/MP4.png`
Aquesta captura mostra el resultat final amb la lògica de monitoratge aplicada:
- Configuració de "Links" entre dispositius per representar connexions físiques o lògiques.
- Definició de triggers que canvien l'estat de la línia o la icona (per exemple, una línia vermella si cau un enllaç de xarxa).
- Verificació del funcionament del mapa sota condicions de producció.

---

## Consideracions Tecniques de Zabbix Maps

### Jerarquia i Navegacio
Zabbix permet la creació de "Submapes". Un element dins d'un mapa pot ser un altre mapa, facilitant la navegació des d'una vista global (ex: Mapa de l'empresa) fins a una de específica (ex: Mapa de la sala de servidors).

### Actualitzacio de Dades
Els mapes s'actualitzen automàticament segons l'interval de refresc configurat al perfil d'usuari o a la pròpia vista del mapa. Això garanteix que qualsevol incident detectat pels agents de Zabbix es reflecteixi visualment de forma gairebé instantània.

### Bones Practiques
- Utilitzar icones estàndard per facilitar la identificació ràpida.
- No sobrecarregar un sol mapa amb massa elements; és preferible utilitzar mapes niats.
- Configurar els permisos de compartició (Sharing) correctament per evitar que usuaris no autoritzats vegin la topologia de la xarxa.

---

## Estructura del Repositori

Per mantenir la coherència amb el sistema de rutes definit, els fitxers s'han d'organitzar així:

```text
.
├── README.md
└── img/
    └── gmail/
        ├── MP1.png
        ├── MP2.png
        ├── MP3.png
        └── MP4.png
