FROM node:11.15-alpine as build-stage

RUN mkdir /app
RUN mkdir /app/front
COPY . /app/front/
WORKDIR /app/front


RUN npm install
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
