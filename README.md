# Docker + Nginx + Php-fpm + Laravel

Docker, nginx, php-fpm, laravel funny example.

## Create Laravel project

Copy to laravel-app ditectory and change .env files.

```sh
composer ceate-project laravel/laravel laravel-app
```

## Config laravel-app/.env

```sh
APP_URL=http://localhost:8000

#DB_CONNECTION=sqlite
DB_CONNECTION=mysql # do not change
DB_HOST=host.docker.internal # do not change
DB_PORT=3306 
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=
```

## Config .env

```sh
DB_ALLOW_EMPTY_PASSWORD=1
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=
```

## Build

```sh
# Build & Run http://localhost:8000
docker compose build --no-cache && docker compose up --force-recreate -d
```

### Examples

```sh
# Up
docker compose up
docker compose up -d

# Up force
docker compose up --force-recreate
docker compose up --force-recreate -d

# Show
docker ps
docker compose ps

# Down refresh
docker compose down -v
docker compose up --build -d

# Run terminal in container
docker compose ps
docker exec -it web_host bash
docker exec -it {service_name_here} sh

# Run in container
docker compose exec php php artisan migrate:fresh

# If a service can run without privileges, use USER to change to a non-root user. 
# USER Start by creating the user and group in the Dockerfile with something like the following example:
RUN groupadd -r postgres && useradd --no-log-init -r -g postgres postgres

# Create user php-fpm composer
RUN usermod -u 1000 www-data

# Change user
USER postgres

# The host has a changing IP address, or none if you have no network access. 
# We recommend that you connect to the special DNS name host.docker.internal, 
# which resolves to the internal IP address used by the host.
host.docker.internal
```

## Network in container

```sh
docker network create --driver bridge --subnet 182.18.0.0/16 custom-network-name
docker network ls
docker inspect custom-network-name
```

## Laravel .env

```sh
DB_CONNECTION=mysql
DB_HOST=host.docker.internal
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=
```

## Install Docker Windows 10 amd wsl

```sh
https://learn.microsoft.com/en-us/windows/wsl/install-manual
# PowerShel as Administrator 
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2
wsl --set-default Debian
# Install
https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# Get docker
https://docs.docker.com/desktop/install/windows-install/
# Add user too docker group
net localgroup docker-users <user> /add
# Optional run as Administratio with cmd: 
"C:\Program Files\Docker\Docker\DockerCli.exe" -SwitchDaemon
# Uninstall WSL
https://gist.github.com/4wk-/889b26043f519259ab60386ca13ba91b
```

## WSL Reinstall

```sh
https://gist.github.com/4wk-/889b26043f519259ab60386ca13ba91b
```
