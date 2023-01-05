#!/bin/bash
echo "$0: Starting SQL Server"
entrypoint-initdb.sh & /opt/mssql/bin/sqlservr