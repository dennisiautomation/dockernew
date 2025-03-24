FROM node:18-alpine

# Instalar git para clonar o repositório
RUN apk add --no-cache git

WORKDIR /app

# Clonar o repositório principal que contém o código-fonte
RUN git clone https://github.com/dennisiautomation/newcastft.git .

# Configurar backend
WORKDIR /app/backend
RUN npm install

# Configurar frontend
WORKDIR /app/frontend
RUN npm install --legacy-peer-deps

# Configurar URL da API
COPY frontend/src/config.js src/config.js

# Build do frontend
RUN npm run build --legacy-peer-deps

# Voltar para o diretório do backend para iniciar a aplicação
WORKDIR /app/backend

# Configurar variáveis de ambiente
ENV PORT=3000
ENV NODE_ENV=production
ENV MONGODB_URI=mongodb://mongodb:27017/newcashft

# Expor a porta
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "server.js"]
