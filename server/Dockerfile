FROM node:20-alpine AS test
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "test"]

FROM node:20-alpine AS base
WORKDIR /app

FROM base AS dev
COPY package*.json ./
RUN npm ci || npm i
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]

FROM base AS prod
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
