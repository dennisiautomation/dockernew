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
RUN npm install

# Corrigir a URL da API no arquivo config.js
RUN sed -i 's|http://localhost:5001/api|http://localhost:3000/api|g' src/config.js || echo "URL já configurada corretamente"

# Construir o frontend
RUN npm run build

# Voltar para o diretório do backend para iniciar a aplicação
WORKDIR /app/backend

# Configurar variáveis de ambiente
ENV PORT=3000
ENV NODE_ENV=production
ENV MONGODB_URI=mongodb://mongodb:27017/newcashft

# Expor a porta
EXPOSE 3000

# Iniciar a aplicação
CMD ["node", "server.js"]
