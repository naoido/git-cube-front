FROM node:latest

WORKDIR /app

COPY ./git-cube/ /app/

RUN npm install

CMD [ "npm", "run", "dev"]