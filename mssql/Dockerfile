# FROM datagrip/datagrip/mssql-server-linux
FROM mcr.microsoft.com/mssql/server

# USER mssql
# CMD ["/opt/mssql/bin/sqlservr"]

RUN mkdir -p /usr/databases

WORKDIR /usr/databases

COPY entrypoint.sh /bin/


# ENTRYPOINT ["entrypoint.sh"]
