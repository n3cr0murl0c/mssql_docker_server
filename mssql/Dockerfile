# FROM datagrip/datagrip/mssql-server-linux
FROM mcr.microsoft.com/mssql/server

RUN mkdir -p /usr/databases

WORKDIR /usr/databases

COPY entrypoint.sh /usr/local/bin/


# ENTRYPOINT ["entrypoint.sh"]
