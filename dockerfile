# Etapa 1 - Build da aplicação
FROM node:22 AS builder

WORKDIR /app

# Copia os arquivos de dependência
COPY package.json pnpm-lock.yaml ./

# Instala o gerenciador pnpm
RUN npm install -g pnpm

# Instala as dependências
RUN pnpm install

# Copia todo o projeto
COPY . .

# Faz o build de produção do Next.js
RUN pnpm build


# Etapa 2 - Imagem de execução (runtime)
FROM node:22 AS runner

WORKDIR /app

# Instala o pnpm novamente
RUN npm install -g pnpm

# Copia os arquivos necessários da etapa de build
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/pnpm-lock.yaml ./pnpm-lock.yaml
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/tsconfig.json ./tsconfig.json
COPY --from=builder /app/next.config.mjs ./next.config.mjs

# Expõe a porta usada pela aplicação
EXPOSE 3000
ENV PORT=5000

# Comando para iniciar a aplicação em produção
CMD ["pnpm", "start"]
