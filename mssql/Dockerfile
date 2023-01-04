FROM mcr.microsoft.com/mssql/server:2022-latest

RUN groupadd -r alphine_cow && useradd -r -g alphine_cow alphine_cow

RUN apt-get update -yqq && \
    apt-get install -yqq \
    git \
    curl \
    zip \
    unzip \
    gzip \
    libzip-dev \
    libicu-dev \
    nano

# Make sure folder exists
RUN mkdir /usr/local/backups

COPY ./backups/* /usr/local/backups/

RUN chown alphine_cow:alphine_cow /usr/local/backups -R