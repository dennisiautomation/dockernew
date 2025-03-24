FROM node:18-alpine

WORKDIR /app

# Copiar todo o projeto
COPY . .

# Construir o frontend
WORKDIR /app/frontend
RUN npm install

# Corrigir a URL da API no arquivo config.js
RUN sed -i 's|http://localhost:5001/api|http://localhost:3000/api|g' src/config.js || echo "URL já configurada corretamente"

# Construir o frontend após a correção
RUN npm run build

# Configurar backend
WORKDIR /app/backend
RUN npm install

# Garantir que o servidor backend possa servir arquivos estáticos
# e manter a configuração de contas (Principal, USD, EUR, USDT)
# sem modificar a lógica das contas FT exclusivas para admin (60248, 60249)
ENV PORT=3000
ENV NODE_ENV=production
ENV MONGODB_URI=mongodb://mongodb:27017/newcashft

# Expor a porta
EXPOSE 3000

# Iniciar a aplicação
CMD ["node", "server.js"]
