#!/bin/bash

# Criar diretórios necessários
mkdir -p certbot/conf
mkdir -p certbot/www

# Parar containers existentes
docker-compose down

# Iniciar apenas o nginx
docker-compose up -d nginx

# Obter o certificado SSL
docker-compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot \
  --email seu-email@exemplo.com --agree-tos --no-eff-email \
  -d global.newcashbank.com.br

# Reiniciar todos os serviços
docker-compose down
docker-compose up -d
