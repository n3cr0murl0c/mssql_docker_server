#FROM datagrip/datagrip/mssql-server-linux
FROM mcr.microsoft.com/mssql/server:latest-stable

RUN mkdir -p /usr/database

WORKDIR /usr/database

RUN mkdir -p /usr/entrypoint

COPY ./backups /usr/database/

COPY . /usr/entrypoint

RUN chmod +rw /usr/database
RUN chmod +x /usr/entrypoint/entrypoint.sh
RUN chmod +x /usr/entrypoint/configure-db.sh