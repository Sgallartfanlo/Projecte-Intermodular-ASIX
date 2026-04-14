# Projecte Docker  
## Orquestradors: Docker Swarm i Kubernetes  
### Plataforma e-Commerce Microserveis  

---

**Oleguer Esteo Martínez**  
**Sergi Gallart Fanlo**  
**Àlex Marqués Comas**

# Fase 1: Docker Compose — Entorn de Desenvolupament

## Introducció Docker Compose

Docker Compose és una eina oficial de Docker que permet definir i executar aplicacions formades per múltiples contenidors. La seva funcionalitat es basa en un únic fitxer de configuració en format YAML, en el qual es descriuen tots els serveis, xarxes i volums necessaris per a una aplicació. Aquest enfocament facilita la gestió de l’aplicació com una unitat, en comptes de gestionar cada contenidor de manera individual.

Docker Compose està dissenyat per simplificar el desplegament i l’administració de conjunts de contenidors que intervenen conjuntament en una aplicació. Això es tradueix en la possibilitat d’arrencar, aturar, reconstruir i obtenir informació de tots els serveis definits de forma coordinada a través d’una sola comanda des de la línia d’ordres.

---

## Arquitectura i funcionament de Docker Compose

La forma de treballar amb Docker Compose es basa en la interacció de diversos components:

### Fitxer de configuració (YAML)

La base de Docker Compose és el fitxer de configuració, anomenat `docker-compose.yml`. Aquest fitxer utilitza la sintaxi YAML per descriure tots els serveis que formen part de l’aplicació, així com les xarxes i volums que cal crear. L’especificació d’aquest fitxer segueix el *Compose Specification* recomanat per Docker.

### CLI de Docker Compose

La interfície de línia d’ordres de Docker Compose s’utilitza per executar ordres com ara:

- `docker compose up`
- `docker compose down`
- `docker compose logs`
- `docker compose ps`

Aquestes ordres interpreten el fitxer de configuració i executen les accions corresponents sobre el conjunt de contenidors i recursos definits.

### Docker Engine

El Docker Engine, que representa el motor de contenidors de Docker, és l’encarregat d’arrencar, executar i gestionar els contenidors a partir de la configuració proporcionada per Docker Compose. Quan s’executa una comanda de Compose, el motor crea les xarxes, assigna els volums i arrenca els serveis tal com s’ha definit en el fitxer YAML.

Aquest model permet que els serveis puguin comunicar-se entre si mitjançant xarxes gestionades internament i que comparteixin dades persistents a través de volums, fet que facilita la construcció d’entorns complexos amb components interconnectats.

---

## Sintaxi del fitxer `docker-compose.yml`

El fitxer `docker-compose.yml` utilitza la sintaxi YAML per descriure l’estructura i la configuració de l’aplicació. La secció principal del fitxer és la directiva `services`, que conté tots els serveis que componen l’aplicació.

Per exemple, un fragment bàsic del fitxer podria ser:

```yaml
services:
  frontend:
    image: myapp/frontend
    ports:
      - "3000:3000"
````

En aquest cas, s’està declarant un servei anomenat `frontend`, que utilitza una imatge anomenada `myapp/frontend` i exposa el port 3000 des del contenidor cap al sistema amfitrió.

Els serveis també poden definir altres paràmetres com variables d’entorn, volums, xarxes i dependències entre serveis. Això permet configurar de forma declarativa com s’ha d’executar cada component de l’aplicació.

---

## Diferències entre `docker compose` i `docker run`

Docker proporciona dues formes principals per crear i executar contenidors:

### `docker run`

La comanda `docker run` és la manera tradicional de crear i iniciar un contenidor de manera individual. Per cada contenidor que es vol executar cal especificar tots els paràmetres necessaris (com ara ports, volums o variables d’entorn) de forma explícita en la línia d’ordres. Aquest enfocament pot resultar repetitiu i difícil de mantenir quan es tracta de múltiples serveis.

### `docker compose`

Docker Compose, en canvi, està orientat a la definició d’aplicacions multi-contenidor. Mitjançant un sol fitxer YAML és possible expressar la configuració de tots els serveis, les xarxes i els recursos compartits. Amb una sola comanda (`docker compose up`) es pot iniciar tota l’aplicació amb tots els serveis i dependències definits de forma automàtica.

---

## Disseny d’arquitectura
![Draw.io](img/fase1/arquitectura.jpg)

L’arquitectura de ShopMicro en entorn Docker Compose està estructurada en tres capes: accés, backend i persistència. El frontend és l’únic servei exposat al port 80, mentre que la resta de microserveis es comuniquen a través de xarxes internes. Les bases de dades, Redis i RabbitMQ es troben a la capa de dades, garantint l’aïllament i la seguretat del sistema.

---
## Creació Docker-Compose

El codi complet del fitxer `docker-compose.yml` utilitzat en aquesta fase del projecte es troba disponible al repositori de GitHub següent:  
--> [Docker-compose](https://github.com/Sgallartfanlo/Projecte-Intermodular-ASIX/blob/main/Kubernetes%20B%C3%A0sic/fase%201/docker-compose.yml)

El fitxer `docker-compose.yml` defineix de forma declarativa tots els **serveis** que formen part de la plataforma **ShopMicro**, així com les xarxes i volums necessaris per al seu funcionament. Dins la secció `services` es configuren les bases de dades **MySQL**, el sistema de cache **Redis**, la cua de missatges **RabbitMQ**, els **microserveis** de negoci, l’`api-gateway` i el `frontend`.

Les bases de dades i serveis de persistència s’executen a la xarxa `data-net` i disposen de **volums** per garantir la persistència de les dades. Els microserveis es connecten tant a `backend-net`, per comunicar-se entre ells, com a `data-net`, per accedir als serveis de dades. S’utilitza la directiva `depends_on` amb la condició `service_healthy` per assegurar que els serveis crítics estiguin operatius abans d’iniciar els microserveis dependents.

L’`api-gateway` actua com a punt d’entrada únic cap als microserveis, mentre que el `frontend` és l’únic servei que exposa el port 80 al sistema amfitrió, permetent l’accés des del navegador. La segmentació en **tres xarxes** (`frontend-net`, `backend-net` i `data-net`) permet millorar l’aïllament, l’organització i la seguretat de l’arquitectura.

---


## Desplegament i verificació

Abans de desplegar, hem creat la estructura de MicroShop bàsica per tal de poder desplegar els serveis sense problemes.  
→ [Directoris](https://github.com/Sgallartfanlo/Projecte-Intermodular-ASIX/tree/main/Kubernetes%20B%C3%A0sic/fase%201)

Per desplegar el `docker-compose.yml` que hem creat, s’ha de fer servir la comanda:

```bash
docker compose up -d
````

![Docker Compose up](img/fase1/compose_up.png)


---

Per verificar que tot el desplegament ha sortit correcte, utilitzarem la comanda:

```bash
docker compose ps
```

On podem veure que estan en **“Healthy”** gràcies al Docker Compose que hem fet.

![Docker ps](img/fase1/docker_ps.png)

---

Una altre manera de veure que tot ha sortit bé, és mirant els logs. Per fer-ho farem servir la comanda:

```bash
docker compose logs
```

![Logs](img/fase1/logs.png)

---

## Flux de consulta de productes

Primer de tot, per comprovar aquest flux accedirem al frontend:

![Accés al frontend](img/fase1/flux1-frontend.png)

Tot seguit, li donarem un cop al botó de “Carrega productes” i veurem que ens mostra un json de el Mysql:

![Consulta des de MySQL](img/fase1/flux1-mysql.png)

Ara si li tornem a clicar al botó, ens mostrarà el mateix, però en comptes de amb el mysql, serà amb el Redis. Ja que el mysql haurà guardat el contingut dins el Redis. És a dir que el sistema buscarà al cache per tal de evitar tornar a accedir dins la base de dades.

![Consulta des de Redis](img/fase1/flux1-redis.png)

## Flux de creació de comanda

Per començar aquesta proba, haurem de obrir dos terminals per captar els logs de “order-service” i “notification-service”.

![Logs order-service i notification-service](img/fase1/flux2-logs-terminals.png)

Tot seguit, tornem a obrir la web per comprar el producte amb id 1 i de quantitat 1.

![Compra producte id 1 quantitat 1](img/fase1/flux2-compra.png)

Just després de clicar el botó de compra, ens sortirà un altre json on ens indica el número de ordre:

![Resposta JSON creació comanda](img/fase1/flux2-json-ordre.png)

També ara els logs ens mostraran que s’ha efectuat la comanda amb més informació addicional, com per exemple la hora i el id.

![Logs després de la compra](img/fase1/flux2-logs-resultat.png)

# Fase 2: Docker Swarm — Clúster d'Alta Disponibilitat

## Inicialitzar clúster swarm al manager i unir els workers

Primer de tot hem de instalar el Docker a les tres màquines.

### Actualitzem paquets:

```bash
sudo apt update
````

### Instal·lem les dependències necessàries:

```bash
sudo apt install ca-certificates curl gnupg -y
```

### Creo el directori per guardar les claus del repositori:

```bash
sudo install -m 0755 -d /etc/apt/keyrings
```

### Afegim la clau GPG oficial de Docker:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### Afegim el repositori oficial de Docker:

```bash
echo \
"deb [arch=$(dpkg --print-architecture) \
signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### Ara ja podem instal·lar amb la següent comanda el Docker:

```bash
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

### Comprovem que s’ha instal·lat correctament:

```bash
docker --version
```

### Permetre utilitzar Docker sense sudo:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

---

## Comprovació de connectivitat entre màquines

Abans de començar amb el Swarm, hem de comprovar que les diferents màquines es veuen entre elles:

```bash
ping IP_DE_LA_ALTRA_MAQUINA
```

![Prova de connexió](img/fase2/pingmaquines.png)

---

## Inicialització del node manager

El primer pas és inicialitzar el clúster des de la màquina que actuarà com a manager. El manager és el node encarregat de controlar el clúster, gestionar els serveis i decidir en quin node s’executaran els contenidors.

Per iniciar el clúster es fa servir la següent comanda:

```bash
docker swarm init
```

Aquesta comanda converteix la màquina actual en el node manager del clúster Docker Swarm.

Quan s’executa, Docker crea automàticament la configuració del clúster i genera un token d’unió que permetrà que altres nodes s’afegeixin al clúster com a workers.

---

## Afegir els nodes workers al clúster

Un cop el manager ha estat inicialitzat, el següent pas és afegir les màquines workers al clúster. Els nodes workers són les màquines que executen els contenidors i serveis distribuïts pel manager.

Per unir un node worker al clúster, cal executar a la màquina worker la comanda que ha proporcionat el manager:

```bash
docker swarm join --token TOKEN_DEL_MANAGER IP_DEL_MANAGER:2377
```

---

## Verificació del clúster

Per comprovar que totes les màquines s’han afegit correctament al clúster, es pot executar la següent comanda al node manager:

```bash
docker node ls
```

![Docker node ls](img/fase2/dockernodels.png)

---

## Creació Docker-Stack

El codi complet del fitxer **docker-stack.yml** utilitzat en aquesta fase del projecte es troba disponible al repositori de GitHub següent: 
--> [Docker-stack](https://github.com/Sgallartfanlo/Projecte-Intermodular-ASIX/blob/main/Kubernetes%20B%C3%A0sic/fase%202/docker-stack.yml)

El fitxer **docker-stack.yml** defineix de forma declarativa tots els serveis que formen part de la plataforma ShopMicro adaptats per funcionar en un clúster de **Docker Swarm**. Dins la secció *services* es configuren les bases de dades MySQL, el sistema de cache Redis, la cua de missatges RabbitMQ, els microserveis de negoci, l’api-gateway i el frontend, igual que en la fase anterior amb Docker Compose.

En aquesta fase s’han afegit directives pròpies de **Docker Swarm** dins la secció *deploy*. En primer lloc, s’ha configurat **deploy.replicas** per executar diverses instàncies dels microserveis, garantint així una major disponibilitat del sistema. També s’ha utilitzat **deploy.placement.constraints** per assegurar que els serveis de bases de dades s’executin sempre al node manager del clúster.

A més, s’ha configurat **deploy.restart_policy** per reiniciar automàticament els contenidors en cas d’error i **deploy.update_config** per permetre actualitzacions progressives dels serveis mitjançant un sistema de *rolling update* amb paral·lelisme d’una rèplica cada vegada.

La segmentació en tres xarxes (**frontend-net**, **backend-net** i **data-net**) es manté igual que en la fase anterior, permetent separar les capes de l’arquitectura i garantir una comunicació controlada entre els diferents serveis de la plataforma.

---

## Desplegament amb Docker Stack

Un cop creat el fitxer `docker-stack.yml`, el següent pas és desplegar l’aplicació dins el clúster **Docker Swarm**. Aquest fitxer és una adaptació del `docker-compose.yml` utilitzat a la fase anterior, però incorpora directives específiques de Swarm com la gestió de rèpliques, les polítiques de reinici automàtic i les restriccions de desplegament dels serveis.

Per desplegar la stack s’utilitza la següent comanda executada des del node **manager**:

```bash
docker stack deploy -c docker-stack.yml shopmicro
```

Aquesta comanda crea una stack anomenada **shopmicro** i desplega tots els serveis definits dins el fitxer `docker-stack.yml` al clúster Docker Swarm.

---

## Verificació dels serveis desplegats

Per comprovar que tots els serveis s’han desplegat correctament es pot utilitzar la següent comanda:

```bash
docker stack services shopmicro
```

Aquesta comanda mostra tots els serveis que formen part de la stack, així com el nombre de rèpliques actives i el port exposat per cadascun d’ells.

En aquesta sortida es pot observar que els microserveis disposen de múltiples rèpliques, tal com s’ha configurat dins del fitxer `docker-stack.yml`. Això permet millorar la disponibilitat del sistema i assegurar que el servei continuï funcionant encara que algun contenidor falli.

![Serveis Docker Stack](img/fase2/docker-stack-services.png)

---

## Distribució dels serveis dins el clúster

Per veure en quin node del clúster s’està executant cada rèplica dels serveis, es pot utilitzar la següent comanda:

```bash
docker stack ps shopmicro
```

Aquesta comanda mostra totes les tasques associades als serveis de la stack, indicant el node on s’està executant cada contenidor.

Gràcies a Docker Swarm, els contenidors es distribueixen automàticament entre els diferents nodes del clúster (`aos-manager`, `aos-worker-1` i `aos-worker-2`). Això permet repartir la càrrega de treball i augmentar la tolerància a errors del sistema.

![Distribució dels serveis al clúster](img/fase2/docker-stack-ps.png)

## Prova de tolerància a fallades

Per comprovar la tolerància a fallades del clúster Docker Swarm, es simula la caiguda d’un dels nodes worker. En aquest cas aturarem el node **Worker 2**.

Primer de tot aturem el **Worker 2**. Per fer-ho executem la següent comanda dins del node `aos-worker-2`:

```bash
sudo systemctl stop docker
```

---

### Comprovació de l'estat dels nodes

Ara, des del node **manager**, executem la següent comanda per veure l’estat dels nodes del clúster:

```bash
docker node ls
```

En aquest moment podem observar que el node **Worker 2** apareix amb estat **Down**, indicant que ha deixat de participar temporalment en el clúster.

![Node worker-2 en estat Down](img/fase2/swarm-node-down.png)

---

### Redistribució automàtica dels serveis

Si ara executem la següent comanda:

```bash
docker stack ps shopmicro
```

podem observar que els serveis que anteriorment s’estaven executant al **Worker 2** s’han redistribuït automàticament entre els altres nodes disponibles del clúster, és a dir, el **manager** i el **worker-1**.

Això demostra que Docker Swarm manté el nombre de rèpliques actives encara que un node deixi de funcionar.

![Redistribució dels serveis](img/fase2/swarm-redistribution.png)

---

### Reincorporació del node al clúster

Ara tornem a encendre el **Worker 2** per comprovar què passa amb els serveis que s’han redistribuït.

Per fer-ho executem de nou la següent comanda dins del node `aos-worker-2`:

```bash
sudo systemctl start docker
```

Un cop fet això, tornem al node **manager** i executem:

```bash
docker node ls
```

Podem observar que el node **Worker 2** torna a aparèixer amb estat **Ready**, indicant que s’ha reincorporat correctament al clúster.

![Node worker-2 recuperat](img/fase2/swarm-node-recovered.png)

---

### Comportament dels serveis després de la recuperació

Tot i que el node **Worker 2** torna a estar actiu, els serveis que s’han redistribuït no tornen automàticament a aquest node.

Això és perquè Docker Swarm ja està complint amb el nombre de rèpliques configurades per als serveis en els nodes que continuen funcionant.

Els serveis només tornarien a redistribuir-se al **Worker 2** si es realitza una actualització del servei o si es modifica el nombre de rèpliques.

## Escalat en calent

En aquesta última prova es realitza un **escalat en calent** del servei `product-service`.
Això significa augmentar el nombre de rèpliques del servei mentre el sistema continua funcionant, sense necessitat d’aturar els contenidors existents.

Per augmentar a **4** les rèpliques del servei `product-service`, executem la següent comanda des del node **manager**:

```bash
docker service scale shopmicro_product-service=4
```

Aquesta comanda indica a Docker Swarm que augmenti el nombre de contenidors actius per aquest servei fins a quatre.

---

### Verificació de l’escalat

Per comprovar que el servei `product-service` s’ha escalat correctament a **4 rèpliques**, executem la següent comanda:

```bash
docker service ls
```

En aquesta sortida es pot observar que el servei `shopmicro_product-service` mostra **4/4 rèpliques actives**, indicant que els quatre contenidors estan en funcionament.

![Escalat del product-service](img/fase2/swarm-scale-service.png)

---

### Distribució de les noves rèpliques

Per veure com Docker Swarm ha distribuït les noves rèpliques entre els diferents nodes del clúster, utilitzem la comanda següent:

```bash
docker stack ps shopmicro
```

En aquesta sortida es pot observar que les quatre instàncies del servei `product-service` s’han repartit entre els nodes disponibles del clúster (`aos-manager`, `aos-worker-1` i `aos-worker-2`).

Aquesta distribució permet repartir la càrrega del servei entre diferents màquines, millorant l’escalabilitat i la disponibilitat del sistema.

![Distribució de les rèpliques del product-service](img/fase2/swarm-scale-distribution.png)

# Fase 3: Seguretat a Docker Swarm
## Anàlisi de vulnerabilitats del docker-stack.yml
[Docker-stack](https://github.com/Sgallartfanlo/Projecte-Intermodular-ASIX/blob/main/Kubernetes%20B%C3%A0sic/fase%202/docker-stack.yml)

Després de revisar el fitxer `docker-stack.yml`, s’han identificat diverses credencials i configuracions sensibles definides en clar, fet que representa un risc de seguretat dins del clúster Docker Swarm.

La primera vulnerabilitat detectada és l’ús de la contrasenya de root de MySQL directament al fitxer de configuració:

```yaml
MYSQL_ROOT_PASSWORD: rootpassword
```

Aquesta credencial apareix als serveis `db-products` i `db-orders`. El problema és que qualsevol usuari amb accés al fitxer podria veure la contrasenya, i a més també podria quedar exposada en inspeccions del servei o en l’historial del projecte.

També s’ha detectat que diversos microserveis utilitzen la mateixa contrasenya en clar per connectar-se a les bases de dades:

```yaml
DB_PASS: rootpassword
```

Això afecta els serveis `product-service`, `order-service` i `user-service`. Aquesta pràctica és insegura perquè distribueix la mateixa credencial sensible per diversos contenidors, augmentant la superfície d’exposició en cas de compromís d’algun servei.

Una altra vulnerabilitat és l’ús de l’usuari `root` com a usuari de connexió a la base de dades:

```yaml
DB_USER: root
```

Encara que funcionalment és vàlid, no és una bona pràctica de seguretat, ja que s’estan utilitzant privilegis massa elevats per a serveis d’aplicació. El recomanable seria utilitzar usuaris específics amb permisos limitats.

A més, el fitxer manté les credencials dins de la secció `environment`, la qual cosa implica que poden quedar visibles fàcilment en un `docker service inspect`, en logs o en configuracions exportades. En entorns reals això és especialment crític, ja que les credencials no haurien d’estar mai escrites en clar dins dels fitxers de desplegament.

## Credencials identificades

* `MYSQL_ROOT_PASSWORD: rootpassword` a `db-products`
* `MYSQL_ROOT_PASSWORD: rootpassword` a `db-orders`
* `DB_PASS: rootpassword` a `product-service`
* `DB_PASS: rootpassword` a `order-service`
* `DB_PASS: rootpassword` a `user-service`
* `DB_USER: root` a diversos serveis d’aplicació

---

# Docker Secrets

En aquesta fase s’han migrat totes les credencials del fitxer [Docker-stack](https://github.com/Sgallartfanlo/Projecte-Intermodular-ASIX/blob/main/Kubernetes%20B%C3%A0sic/fase%202/docker-stack.yml) a **Docker Secrets**.

L’objectiu és millorar la seguretat del clúster Docker Swarm evitant que les contrasenyes apareguin en text pla dins del fitxer de configuració o en variables d’entorn. Docker Secrets permet emmagatzemar informació sensible de forma segura i només la posa a disposició dels serveis que la necessiten.

---

## Creació del secret

Des del node **manager** es crea el secret que contindrà la contrasenya de la base de dades amb la següent comanda:

```bash
echo "rootpassword" | docker secret create db_root_password -
```

Aquesta comanda crea un secret anomenat `db_root_password` dins del clúster Docker Swarm.

![Creació Docker Secret](img/fase3/docker-secret.png)

---

## Verificació del secret

Per comprovar que el secret s’ha creat correctament es pot utilitzar la comanda:

```bash
docker secret ls
```

Aquesta comanda mostra tots els secrets disponibles dins del clúster.

![Llista Docker Secret](img/fase3/docker-secret-ls.png)

---

## Modificació del docker-stack.yml

Un cop creat el secret, es modifica el fitxer `docker-stack.yml` per substituir les contrasenyes en text pla per l’ús del secret.

Per exemple, en el servei de MySQL es substitueix la variable:

```yaml
MYSQL_ROOT_PASSWORD: rootpassword
```

per:

```yaml
MYSQL_ROOT_PASSWORD_FILE: /run/secrets/db_root_password
```

D’aquesta manera, el contenidor obté la contrasenya directament del secret gestionat per Docker.

També s’ha afegit la secció `secrets` als serveis que necessiten accedir a la contrasenya.

---

## Redeplegament del stack

Un cop modificat el fitxer de configuració, es torna a desplegar la stack amb la següent comanda:

```bash
docker stack deploy -c docker-stack.yml shopmicro
```

Aquesta comanda actualitza els serveis del clúster aplicant la nova configuració amb Docker Secrets.

---

## Verificació dels serveis

Per comprovar que tots els serveis continuen funcionant correctament després dels canvis, es pot utilitzar la comanda:

```bash
docker stack services shopmicro
```

Aquesta comanda mostra l’estat dels serveis desplegats i el nombre de rèpliques actives de cadascun.

![Serveis desplegats](img/fase3/serveis-desplegats.png)

---

## Verificació de l’ús del secret

Finalment, es pot comprovar que la contrasenya ja no apareix en text pla inspeccionant un dels serveis amb la comanda:

```bash
docker service inspect shopmicro_db-products
```

En la configuració del servei es pot observar que la contrasenya es carrega des del fitxer del secret:

```
MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db_root_password
```

![Comprovació Docker Secret](img/fase3/comprovació-Docker-secret.png)

---

# Aïllament de xarxes Overlay

En aquesta fase es revisa la configuració de xarxes del clúster Docker Swarm per assegurar que cada component del sistema només pot comunicar-se amb els serveis estrictament necessaris. Aquesta separació permet millorar la seguretat del sistema i reduir la superfície d'atac.

Per aconseguir aquest aïllament s'han definit tres xarxes overlay dins del fitxer `docker-stack.yml`:

- `frontend-net`
- `backend-net`
- `data-net`

Cada servei només està connectat a les xarxes que necessita per funcionar.

---

## Xarxa frontend

La xarxa `frontend-net` s'utilitza per connectar la interfície web amb el punt d'entrada del sistema.

Els serveis connectats a aquesta xarxa són:

- `frontend`
- `api-gateway`

D'aquesta manera el servei `frontend` només pot comunicar-se amb l'`api-gateway`, que és el component responsable de gestionar les peticions i redirigir-les cap als microserveis interns.

---

## Xarxa backend

La xarxa `backend-net` s'utilitza per a la comunicació entre l'`api-gateway` i els microserveis de l'API.

Els serveis connectats a aquesta xarxa són:

- `api-gateway`
- `product-service`
- `order-service`
- `user-service`
- `notification-service`

Aquesta configuració permet que l'`api-gateway` gestioni totes les peticions cap als microserveis, evitant que el `frontend` accedeixi directament a aquests serveis.

---

## Xarxa de dades

La xarxa `data-net` s'utilitza per a la comunicació amb els serveis de dades.

Els serveis connectats a aquesta xarxa són:

- `db-products`
- `db-orders`
- `cache`
- `message-queue`
- microserveis que necessiten accés a dades

Aquesta separació assegura que les bases de dades només siguin accessibles pels microserveis que realment les utilitzen.

---

## Bases de dades no exposades

Els serveis de base de dades (`db-products` i `db-orders`) no tenen cap port publicat amb la directiva `ports`.

Això significa que:

- No són accessibles des de l'exterior del clúster
- Només poden ser utilitzades pels serveis connectats a la xarxa `data-net`

Aquesta configuració evita accessos directes a les bases de dades des de fora del sistema.

---

## Verificació de les xarxes

Per comprovar les xarxes creades dins del clúster es pot utilitzar la següent comanda:

```bash
docker network ls
````
![docker network ls](img/fase3/docker-network-ls.png)

Aquesta comanda mostra totes les xarxes disponibles al sistema.

Per inspeccionar una xarxa concreta i veure quins serveis hi estan connectats es pot utilitzar:

```bash
docker network inspect shopmicro_backend-net
```
![docker network inspect shopmicro_backend-net](img/fase3/docker-network-inspect1.png)
![docker network inspect shopmicro_backend-net](img/fase3/docker-network-inspect2.png)

# TLS i certificats al clúster

Docker Swarm utilitza automàticament **TLS (Transport Layer Security)** per protegir la comunicació entre els nodes del clúster.  
Quan s’inicialitza un clúster Swarm, Docker crea una **CA interna (Certificate Authority)** que s’encarrega de generar i gestionar els certificats de tots els nodes.

Aquests certificats permeten:

- Autenticar els nodes del clúster
- Xifrar la comunicació entre managers i workers
- Garantir que només nodes autoritzats poden unir-se al clúster

Cada node del clúster rep automàticament un certificat signat per la CA interna de Docker Swarm.

---

## Verificació de la configuració TLS

Per comprovar que el clúster utilitza TLS i veure informació del Swarm, es pot executar la següent comanda des del **manager**:

```bash
docker info | grep -A5 'Swarm'
````

Aquesta comanda mostra informació sobre l’estat del clúster, incloent si el node és manager, l’identificador del node i altres paràmetres relacionats amb el Swarm.

![Verificació del TLS](img/fase3/docker-info.png)

---

## Certificats del node manager

Docker Swarm genera automàticament certificats per a cada node del clúster.
Aquests certificats es troben al directori:

```
/var/lib/docker/swarm/certificates/
```

En aquest directori es poden trobar diversos fitxers relacionats amb els certificats TLS del node, com per exemple:

* `swarm-node.crt`
* `swarm-node.key`
* `swarm-root-ca.crt`

Aquests fitxers s’utilitzen per autenticar el node dins del clúster i per establir connexions segures amb la resta de nodes.

---

## Inspecció del certificat

Per veure informació sobre el certificat utilitzat pel node es pot utilitzar la següent comanda:

```bash
docker node inspect self
```

Aquesta comanda mostra informació detallada del node actual dins del clúster Swarm, incloent dades sobre el certificat TLS utilitzat per a la seva autenticació.

![Inspecció del certificat](img/fase3/docker-node-inspect1.png)
![Inspecció del certificat](img/fase3/docker-node-inspect2.png)

---

# Escaneig de vulnerabilitats de les imatges
## Instal·lació de Trivy

Primer s'ha instal·lat **Trivy** al node manager per poder analitzar les imatges utilitzades dins del clúster.

```bash
sudo apt install wget apt-transport-https gnupg lsb-release -y
````

```bash
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
```

```bash
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/trivy.list
```

```bash
sudo apt update
```

```bash
sudo apt install trivy -y
```

Un cop instal·lada l'eina, es pot comprovar que la instal·lació s'ha realitzat correctament amb la següent comanda:

```bash
trivy --version
```
---

## Escaneig de la imatge MySQL

Una de les imatges utilitzades al projecte és **mysql:8.0**. Aquesta imatge s'ha analitzat amb Trivy per detectar possibles vulnerabilitats.

```bash
trivy image mysql:8.0
```

Durant l'escaneig, Trivy analitza tots els paquets instal·lats dins la imatge i mostra les vulnerabilitats trobades classificades segons el seu nivell de severitat.

Els nivells de severitat són:

* **CRITICAL**
* **HIGH**
* **MEDIUM**
* **LOW**

![Escaneig de la imatge MySQL](img/fase3/trivy-mysql.png)
![Escaneig de la imatge MySQL](img/fase3/trivy-mysql1.png)

---

## Escaneig d'una altra imatge del projecte

També s'ha analitzat una altra imatge utilitzada dins del projecte, com per exemple **redis:7**.

```bash
trivy image redis:7
```

Aquest escaneig permet comprovar si la imatge conté vulnerabilitats en el sistema base o en les dependències utilitzades pel servei.

![Escaneig de la imatge Redis](img/fase3/trivy-redis.png)

---

## Mesures de seguretat recomanades

Per reduir el risc associat a vulnerabilitats en imatges Docker es poden aplicar diverses mesures de seguretat:

* Utilitzar versions actualitzades de les imatges
* Utilitzar imatges mínimes com **alpine** o **slim**
* Actualitzar regularment les dependències del sistema
* Escanejar les imatges abans de desplegar-les en producció
* Evitar utilitzar imatges amb vulnerabilitats **CRITICAL** sense aplicar actualitzacions

---

# Fase 4: Kubernetes — Migració i Gestió Avançada
## Comparativa entre Docker Swarm i Kubernetes

Per entendre les diferències entre Docker Swarm i Kubernetes s'ha realitzat una comparativa aplicada al projecte **ShopMicro**, que utilitza una arquitectura de microserveis.

| Característica | Docker Swarm | Kubernetes |
|---|---|---|
| Escalat | Permet escalar serveis amb `docker service scale` o definint rèpliques al `docker-stack.yml`. | Permet escalar pods modificant les rèpliques dels Deployments o utilitzant autoscaling (HPA). |
| Self-healing | Si un contenidor falla, Swarm el reinicia automàticament per mantenir el nombre de rèpliques. | Kubernetes recrea automàticament els pods que fallen per mantenir l'estat desitjat. |
| Rolling updates | Permet actualitzar serveis progressivament amb `update_config`. | Els Deployments permeten rolling updates automàtics i rollback si hi ha errors. |
| Gestió de secrets | Utilitza Docker Secrets per protegir credencials sensibles. | Kubernetes utilitza Secrets per gestionar dades sensibles com contrasenyes o tokens. |
| Networking | Utilitza xarxes overlay per comunicar serveis entre nodes. | Kubernetes utilitza Services per permetre la comunicació entre pods dins del clúster. |
| Complexitat | Més simple d'instal·lar i gestionar. | Més complex però molt més flexible i escalable. |

En el projecte **ShopMicro**, Docker Swarm ha estat utilitzat per desplegar inicialment els microserveis. Posteriorment, Kubernetes permet una gestió més avançada del sistema, especialment en aspectes com l'escalabilitat, l'automatització i la gestió de recursos.

---

# Preparació de l'entorn Kubernetes
## Instal·lació de kubectl
Primer s'ha instal·lat **kubectl**, que és l'eina de línia de comandes utilitzada per interactuar amb Kubernetes.

Un cop instal·lat es pot comprovar que funciona correctament amb:
```bash
kubectl version --client
```
![Comprovació instal·lació kubectl](img/fase4/kubectl-version.png)

## Configuració del clúster amb Docker Desktop
En lloc d'usar Minikube, s'ha optat per utilitzar el clúster de **Kubernetes v1.30.x** integrat a **Docker Desktop**.
Els passos realitzats han estat:
1. Activar l'opció **"Enable Kubernetes"** des del menú de configuració de Docker Desktop.
2. Configurar el terminal de WSL per apuntar al context correcte mitjançant la comanda:
```bash
kubectl config use-context docker-desktop
```

## Verificació del clúster
Per assegurar que el clúster està operatiu i que kubectl té comunicació amb el control plane, s'ha executat:
```bash
kubectl cluster-info
```
Aquesta comanda confirma que el clúster de Kubernetes està funcionant correctament a la xarxa interna de Docker.
![Verificació cluster-info](img/fase4/kubectl-cluster-info.png)

## Creació de fitxers YAML per a Kubernetes:
En aquesta secció es detalla la configuració de cadascun dels microserveis de la plataforma. Tots els arxius es troben allotjats al següent repositori:
👉 [GitHub - ShopMicro Kubernetes Fase 4](https://github.com/Sgallartfanlo/Projecte-Intermodular-ASIX/tree/main/Kubernetes%20B%C3%A0sic/fase%204)

### Configuració Global i Seguretat (01-config.yaml)
Aquest fitxer és la base de la infraestructura, ja que defineix com els serveis es troben entre si i com es gestionen les dades sensibles.
* **ConfigMap (shopmicro-config):** Defineix variables d'entorn no sensibles com MYSQL_HOST_PRODUCTS, MYSQL_HOST_ORDERS, REDIS_HOST i RABBITMQ_HOST. Això permet que, si l'arquitectura canvia, només calgui modificar aquest fitxer central.
* **Secret (shopmicro-secrets):** Gestió de credencials xifrades en base64. S'utilitza per emmagatzemar la contrasenya d'arrel de MySQL (mysql-root-password), garantint que cap contrasenya aparegui en text pla als desplegaments.

### Infraestructura de Dades (02-infraestructura.yaml)
Defineix els motors de base de dades, cua i memòria cau.
* **Deployments (Bases de dades, Redis i RabbitMQ):**
    * S'utilitzen imatges oficials com mysql:8.0, redis:7.2-alpine i rabbitmq:3.12-management-alpine.
    * **Liveness Probes:** Cada base de dades inclou una prova de vida mitjançant mysqladmin ping per reiniciar el contenidor automàticament si el motor de BD es bloqueja.
* **Services:** Tots els serveis d'infraestructura s'exposen internament mitjançant ClusterIP, assegurant que les bases de dades no siguin accessibles des de fora del clúster per motius de seguretat.

### Orquestració de Microserveis (03-serveis.yaml i 05-apis.yaml)
És el nucli de l'aplicació on resideix la lògica de negoci.
* **Readiness Probes:** Cada microservei (product, order, user) té configurada una sonda httpGet al port 5000 a la ruta /health. Kubernetes no enviarà trànsit a aquests pods fins que l'aplicació Flask estigui totalment inicialitzada.
* **Volums i Injecció de Codi:** En lloc de crear imatges personalitzades cada vegada, el codi Python s'injecta mitjançant ConfigMaps (product-api-code, order-api-code, etc.) que es munten com a volums de lectura a /app.
* **Escalabilitat:** El product-service s'ha configurat amb 2 rèpliques per defecte per complir amb els requisits d'alta disponibilitat.

### Frontend i Gateway (04-frontend.yaml i gateway-config.yaml)
Gestiona la interfície d'usuari i el trànsit d'entrada.
* **Frontend:** Utilitza un contenidor nginx:alpine on s'injecta el fitxer index.html des d'un ConfigMap. Aquest fitxer conté tota la lògica de la interfície reactiva per a la botiga.
* **API Gateway:** És el cervell del trànsit d'entrada. La seva configuració (nginx.conf) inclou:
    * **Proxy Pass:** Redirigeix peticions segons la ruta (ex: /api/products va cap al product-service).
    * **Resolver:** Utilitza el DNS intern de Kubernetes (10.96.0.10) per resoldre els noms dels serveis en temps real.
* **NodePort Service:** El servei api-gateway-service és l'únic punt d'exposició extern, configurat al port 30080, permetent que l'usuari final accedeixi a la plataforma ShopMicro des de localhost:30080.

## Creació del namespace
Per tal d'aïllar tots els recursos del projecte ShopMicro i mantenir l'entorn organitzat segons les bones pràctiques d'orquestració avançada, s'ha creat un Namespace específic:
```bash
kubectl create namespace shopmicro
```

Finalment, s'ha verificat la presència del node de Docker Desktop amb l'estat Ready:
```bash
kubectl get nodes
```
![Comprovació estat del Node Ready](img/fase4/kubectl-get-nodes.png)

Si el node apareix com a Ready, el clúster està preparat per rebre els desplegaments de la plataforma.

## Migració i desplegament
### Aplicació dels manifests
Per realitzar un desplegament ordenat i assegurar que tots els recursos es creen dins de l'entorn d'aïllament, s'ha utilitzat la següent comanda des de l'arrel del directori on es troben els fitxers:
```bash
kubectl apply -f . -n shopmicro
```
Aquesta comanda processa de forma seqüencial des dels Secrets i ConfigMaps fins dels Deployments i Serveis, establint tota la pila tecnològica de la botiga.

### Verificació de l'estat dels Pods
S'ha comprovat que l'orquestrador ha estat capaç d'aixecar totes les instàncies correctament. L'estat Running i el valor 1/1 a la columna Ready indiquen que les Readiness Probes han passat amb èxit.
```bash
kubectl get pods -n shopmicro
```
![Llistat de Pods en estat Running](img/fase4/kubectl-get-pods.png)

### Verificació dels Serveis (Networking)
S'ha validat la xarxa interna i externa del projecte. Es confirma que cada component té la seva IP interna (ClusterIP) i que el Gateway té el port mapejat cap a l'exterior.
```bash
kubectl get services -n shopmicro
```
![Llistat de Serveis ClusterIP i NodePort](img/fase4/kubectl-get-services.png)

* **api-gateway-external:** Tipus NodePort, exposant el port 80 del contenidor al port 30080 del node.
* **db-products / db-orders:** Tipus ClusterIP, accessibles només internament per les APIs al port 3306.
* **cache / message-queue:** Serveis interns per a Redis i RabbitMQ.

### Inspecció detallada del Deployment: product-service
Per assegurar que les polítiques d'alta disponibilitat i les sondes de salut estan ben aplicades, s'ha inspeccionat el recurs principal de la plataforma.
```bash
kubectl describe deployment product-service -n shopmicro
```
![Detalls del Deployment product-service](img/fase4/kubectl-describe-deployment.png)

En el resultat d'aquesta comanda s'han verificat els següents punts crítics:
* **Replicas:** 2 desired | 2 updated | 2 total | 2 available (Garanteix que el servei no cau si falla un pod).
* **Liveness/Readiness:** Es confirma que Kubernetes consulta /health cada 10-30 segons.
* **Environment:** Es veu com es carreguen les variables des del ConfigMap shopmicro-config.
* **Events:** Es documenta que el procés de Scaling i Deployment s'ha realitzat sense errors (Successfully pulled image, Created container).

## Rolling update
El Rolling Update és l'estratègia per defecte de Kubernetes per actualitzar la versió d'un Deployment. En lloc d'aturar tots els contenidors alhora, Kubernetes els substitueix de forma gradual, garantint que sempre hi hagi rèpliques disponibles per atendre les peticions dels usuaris.

### Procés d'execució de l'actualització
Per documentar aquest procés, s'ha actualitzat la imatge del microservei product-service a una versió superior (per exemple, de la versió de prova python:3.9-slim a python:3.10-slim) mitjançant la següent comanda:
```bash
kubectl set image deployment/product-service product-api=python:3.10-slim -n shopmicro
```

### Monitorització del desplegament progressiu
Un cop llançada la comanda, s'ha utilitzat kubectl rollout status i kubectl get pods per observar el comportament de l'orquestrador en temps real:
* **Creació gradual:** Kubernetes crea un nou Pod amb la imatge actualitzada.
* **Validació amb Readiness Probes:** El nou Pod no rep trànsit fins que la seva Readiness Probe (definida al fitxer 03-serveis.yaml apuntant a /health) confirma que l'aplicació està llista.
* **Substitució:** Un cop el nou Pod està actiu, Kubernetes procedeix a aturar i eliminar un dels Pods de la versió antiga.
* **Finalització:** El procés es repeteix fins que totes les rèpliques (les 2 definides en l'arquitectura) estan executant la nova imatge.

### Evidències documentals
Per a la memòria, s'han capturat les següents dades que demostren l'èxit de l'operació: 
* **Estat del Rollout:** La sortida de `kubectl rollout status deployment/product-service -n shopmicro` indicant "successfully rolled out". 
![Estat del rollout status](img/fase4/rollout-status.png)

* **Historial de revisions:** Mitjançant `kubectl rollout history`, es pot comprovar que el desplegament té ara una nova revisió, permetent un Rollback ràpid en cas d'error. 
![Historial de revisions rollout history](img/fase4/rollout-history.png)

* **Captura de Pods:** Una seqüència de `kubectl get pods -n shopmicro` on es visualitzen simultàniament els Pods.
![Pods durant el rolling update](img/fase4/rollout-pods.png)

## Comprovació dels fluxos funcionals
Per comprobar el flux de la consulta de productes hem de entrar a la web i fixar-nos en la part de la següent captura:
![Web ShopMicro inicial: dades des de MySQL](img/fase4/web-mysql.png)

* Veiem que ara està mirant de la base de dades mysql. Pero si comprem algo o mirem les comandes al tornar a aquesta secció veurem que les dades les treu del caché de redis.
![Web ShopMicro: dades des de la Cache de Redis](img/fase4/web-redis.png)

Per a comprovar el següent flux haurem de fer una comanda:
* Un cop tinguem la comanda seleccionada, si li donem a comprar enviara una notificació al rabbitMQ i descomptara el stock que quedi.
![Logs del Notification Service rebent comanda de RabbitMQ](img/fase4/logs-compra.png)

Per demostrar el flux tres, eliminare el pod de product-service per veure que pasa:
![Eliminació manual d'un Pod](img/fase4/delete-pod.png)

I si tornem a llistar els pods, podem veure que torna a estar-hi:
![Auto-recuperació del Pod (Self-healing)](img/fase4/self-healing.png)


# Webgrafia

* Documentació oficial de Docker Compose:
  [https://docs.docker.com/compose/](https://docs.docker.com/compose/)

* Referència del fitxer Compose:
  [https://docs.docker.com/reference/compose-file/](https://docs.docker.com/reference/compose-file/)

* Model d’aplicació de Docker Compose:
  [https://docs.docker.com/compose/intro/compose-application-model/](https://docs.docker.com/compose/intro/compose-application-model/)

* Referència de la CLI de Docker Compose:
  [https://docs.docker.com/reference/cli/docker/compose/](https://docs.docker.com/reference/cli/docker/compose/)

* Documentació oficial de Docker Engine:
  [https://docs.docker.com/engine/](https://docs.docker.com/engine/)

  * Documentació oficial de Docker Swarm:
  [https://docs.docker.com/engine/swarm/](https://docs.docker.com/engine/swarm/)

* Documentació de Docker Stack:
  [https://docs.docker.com/engine/swarm/stack-deploy/](https://docs.docker.com/engine/swarm/stack-deploy/)

* Documentació de Docker Secrets:
  [https://docs.docker.com/engine/swarm/secrets/](https://docs.docker.com/engine/swarm/secrets/)

* Documentació de xarxes Overlay a Docker:
  [https://docs.docker.com/network/overlay/](https://docs.docker.com/network/overlay/)

* Documentació de seguretat a Docker Swarm:
  [https://docs.docker.com/engine/swarm/security/](https://docs.docker.com/engine/swarm/security/)

* Documentació oficial de Trivy:
  [https://aquasecurity.github.io/trivy/](https://aquasecurity.github.io/trivy/)

* Base de dades de vulnerabilitats CVE:
  [https://cve.mitre.org/](https://cve.mitre.org/)

* Documentació oficial de Kubernetes:
  [https://kubernetes.io/docs/home/](https://kubernetes.io/docs/home/)

* Referència de l'API de Kubernetes:
  [https://kubernetes.io/docs/reference/kubernetes-api/](https://kubernetes.io/docs/reference/kubernetes-api/)

* Model de desplegament de Pods:
  [https://kubernetes.io/docs/concepts/workloads/pods/](https://kubernetes.io/docs/concepts/workloads/pods/)

* Documentació de Kubernetes Services:
  [https://kubernetes.io/docs/concepts/services-networking/service/](https://kubernetes.io/docs/concepts/services-networking/service/)

* Referència de Kubernetes ConfigMaps:
  [https://kubernetes.io/docs/concepts/configuration/configmap/](https://kubernetes.io/docs/concepts/configuration/configmap/)

* Documentació de Kubernetes Secrets:
  [https://kubernetes.io/docs/concepts/configuration/secret/](https://kubernetes.io/docs/concepts/configuration/secret/)

* Documentació de Volums Persistents (PV):
  [https://kubernetes.io/docs/concepts/storage/persistent-volumes/](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
