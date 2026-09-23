FROM node:24-alpine

WORKDIR /app
## cache layer optimization here. copy only files needed for npm install then copy the rest
COPY app/package*.json ./
## this way if any changes are made to other files a full  install will not run again
RUN npm ci --omit=dev
## copying rest of files after install..
COPY app/ ./
## metadata
EXPOSE 3000

USER node

CMD ["node", "server.js"]