# Use uma imagem base oficial do Node.js (versão 18 ou superior)
FROM node:22

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie os arquivos de dependências (package.json, pnpm-lock.yaml)
COPY package.json pnpm-lock.yaml ./

# Instale o pnpm globalmente
RUN npm install -g pnpm

# Instale as dependências usando o pnpm
RUN pnpm install

# Copie o restante do código para dentro do contêiner
COPY . .

# Exponha a porta que a aplicação vai usar
EXPOSE 5000

# Comando para rodar a aplicação (ajuste conforme necessário)
CMD ["pnpm", "start"]
