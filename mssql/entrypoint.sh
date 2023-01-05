#!/bin/bash

# wait for database to start...
echo "$0: SQL Server startup in progress"
until /opt/mssql-tools/bin/sqlcmd -U SA -P ${MSSQL_SA_PASSWORD} -Q 'SELECT 1;' &> /dev/null; do
  echo -n "."
  sleep 1
done

echo "$0: Initializing database"
for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.sql)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -U SA -P ${MSSQL_SA_PASSWORD} -X -i  "$f"; echo ;;
    meGeneral.bak)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD}  -Q "RESTORE DATABASE meGeneral FROM DISK ='/docker-entrypoint-initdb.d/meGeneral.bak' WITH MOVE 'meGeneral' TO '/var/opt/mssql/data/meGeneral.mdf', MOVE 'meGeneral_log' TO '/var/opt/mssql/data/meGeneral_log.ldf', RECOVERY, REPLACE, STATS=10";;
    meSivera1.bak)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD}  -Q "RESTORE DATABASE meSivera1 FROM DISK ='/docker-entrypoint-initdb.d/meSivera1.bak' WITH MOVE 'meSivera1' TO '/var/opt/mssql/data/meSivera1.mdf', MOVE 'meSivera1_log' TO '/var/opt/mssql/data/meSivera1_log.ldf', RECOVERY, REPLACE, STATS=10";;
    meSivera2.bak)    echo "$0: running $f"; /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P ${MSSQL_SA_PASSWORD}  -Q "RESTORE DATABASE meSivera2 FROM DISK ='/docker-entrypoint-initdb.d/meSivera2.bak' WITH MOVE 'meSivera2' TO '/var/opt/mssql/data/meSivera2.mdf', MOVE 'meSivera2_log' TO '/var/opt/mssql/data/meSivera2_log.ldf', RECOVERY, REPLACE, STATS=10";;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done
echo "$0: SQL Server Database ready"