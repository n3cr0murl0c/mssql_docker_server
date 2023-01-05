#!/bin/bash

# Start the script to create the DB and user
/usr/config/configure-db.sh &

# Start SQL Server
/opt/mssql/bin/sqlservr




#!/bin/bash

# wait for database to start...
echo "$0: SQL Server startup in progress"
until sqlcmd -U SA -P ${MSSQL_SA_PASSWORD} -Q 'SELECT 1;' &> /dev/null; do
  echo -n "."
  sleep 1
done

echo "$0: Initializing database"
for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.sql)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -U SA -P ${MSSQL_SA_PASSWORD} -X -i  "$f"; echo ;;
    meGeneral.bak)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD}  -Q "RESTORE DATABASE meGeneral FROM DISK ='/home/meSivera1.bak' WITH MOVE 'meGeneral' TO '/home/meGeneral.mdf', MOVE 'meGeneral_log' TO '/home/meGeneral_log.ldf', RECOVERY, REPLACE, STATS=10";;
    meSivera1.bak)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD}  -Q "RESTORE DATABASE meSivera1 FROM DISK ='/home/meSivera1.bak' WITH MOVE 'meSivera1' TO '/home/meSivera1.mdf', MOVE 'meSivera1_log' TO '/home/meSivera1_log.ldf', RECOVERY, REPLACE, STATS=10";;
    meSivera2.bak)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD}  -Q "RESTORE DATABASE meSivera2 FROM DISK ='/home/meSivera1.bak' WITH MOVE 'meSivera2' TO '/home/meSivera2.mdf', MOVE 'meSivera2_log' TO '/home/meSivera2_log.ldf', RECOVERY, REPLACE, STATS=10";;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done
echo "$0: SQL Server Database ready"