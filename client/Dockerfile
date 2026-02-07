FROM node:20-alpine AS base
WORKDIR /app

FROM base AS dev
COPY package*.json ./
RUN npm ci || npm i
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "5173"]

FROM base AS build
COPY package*.json ./
RUN npm ci || npm i
COPY . .
RUN npm run build