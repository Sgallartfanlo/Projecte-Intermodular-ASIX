#Crear script:
nano /opt/scriptBackupZabbix.sh

#!/bin/bash
# Variables de configuració
DB_USER="My_User"
DB_PASSWORD="My_Password"
DB_NAME="My_Zabbix_Db_Name"
BACKUP_DIR="/mnt/My_Backup_Folder"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/zabbix_backup_$TIMESTAMP.sql"
LOG_FILE="/tmp/zabbix_backup_log.txt"

# Comanda per fer el bolcat de la base de dades de Zabbix i guardar la sortida en el fitxer de registre
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE

# Verificar si el bolcat va ser exitós
if [ $? -eq 0 ]; then
  echo "Bolcat de base de dades completat amb èxit en $BACKUP_FILE"

  # Llista de còpies de seguretat més antigues a mantenir (en aquest cas, 7)
  OLD_BACKUPS=$(ls -t $BACKUP_DIR/zabbix_backup_*.sql | tail -n +8)

  # Eliminar còpies de seguretat més antigues
  if [ -n "$OLD_BACKUPS" ]; then
    echo "Eliminant còpies de seguretat més antigues:"
    echo "$OLD_BACKUPS" | xargs rm
  fi

 # Comanda per copiar la còpia de seguretat a la unitat muntada
 # cp $BACKUP_FILE "$BACKUP_DIR/zabbix_backup_latest.sql"

  # Verificar si la còpia va ser exitosa
  if [ $? -eq 0 ]; then
    echo "Còpia de seguretat realitzada en $BACKUP_DIR/zabbix_backup_latest.sql" | tee -a $LOG_FILE
  else
    echo "Error en copiar la còpia de seguretat a $BACKUP_DIR" | tee -a $LOG_FILE
  fi
else
  echo "Error en fer el bolcat de la base de dades" | tee -a $LOG_FILE
fi


- Donar permisos d'execució al script:
chmod +x /opt/scriptBackupZabbix.sh

- Crear carpeta dins de /mnt/
mkdir /mnt/Backup

- Editar fstab per establir el punt de muntatge:
nano /etc/fstab

- Enganxar la següent línia editant els paràmetres segons correspongui:
//IP_server/Folder_Shared /mnt/Backup_Folder_Name/ cifs rw,username=backup,password=094cf20512fffc80cd*,uid=root,gid=root 0 0

- Muntar la carpeta compartida:
mount -a

- Editar Cron per crear una tasca automàtica
crontab -e

- Exemple de Cron, editar segons les teves necessitats:
0 2 * * * /opt/scriptBackupZabbix.sh

- Reiniciar Cron perquè apliqui els canvis:
/etc/init.d/cron restart
