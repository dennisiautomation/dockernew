FROM node:18-alpine

WORKDIR /app

# Copiar todo o projeto
COPY . .

# Construir o frontend
WORKDIR /app/frontend
RUN npm install
RUN npm run build

# Configurar backend
WORKDIR /app/backend
RUN npm install

# Corrigir configuração da API se necessário 
RUN cd /app/frontend/build && \
    find . -type f -name "*.js" -exec sed -i 's|http://localhost:5001/api|http://localhost:3000/api|g' {} \; || true

# Configurar o backend para servir os arquivos estáticos
ENV PORT=3000
ENV NODE_ENV=production

# Expor a porta
EXPOSE 3000

# Iniciar a aplicação
CMD ["node", "server.js"]
