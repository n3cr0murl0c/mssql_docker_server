#FROM datagrip/datagrip/mssql-server-linux
FROM mcr.microsoft.com/mssql/server

RUN mkdir -p /usr/databases

WORKDIR /usr/databases

ENV PATH $PATH:/opt/mssql-tools/bin

COPY entrypoint.sh /usr/local/bin/
COPY entrypoint-initdb.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
