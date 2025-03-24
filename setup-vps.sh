#!/bin/bash

# Instalar Certbot e Nginx se não estiverem instalados
apt-get update
apt-get install -y certbot python3-certbot-nginx nginx

# Obter certificado SSL
certbot certonly --nginx -d global.newcashbank.com.br --non-interactive --agree-tos -m seu-email@exemplo.com

# Copiar configuração do Nginx
cp nginx-site.conf /etc/nginx/sites-available/global.newcashbank.com.br
ln -sf /etc/nginx/sites-available/global.newcashbank.com.br /etc/nginx/sites-enabled/

# Remover configuração padrão do Nginx
rm -f /etc/nginx/sites-enabled/default

# Testar e recarregar Nginx
nginx -t && systemctl reload nginx

# Construir e iniciar o container
docker-compose down
docker-compose up -d --build
