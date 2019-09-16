FROM node:11.15-alpine as build-stage

RUN mkdir /app
RUN mkdir /app/front
COPY . /app/front/
WORKDIR /app/front

RUN npm i -g pm2
RUN npm install

CMD ["pm2-runtime", "start", "/app/front/pm2-dev.json"]