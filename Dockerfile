FROM node:16.14.0-alpine as service1
WORKDIR /usr/service/
COPY ./package.json .
RUN npm install
COPY . .
CMD [ "node", "service1.js" ]

FROM node:16.14.0-alpine as service2
WORKDIR /usr/service/
COPY ./package.json .
RUN npm install
COPY . .
CMD [ "node", "service2.js" ]

FROM node:16.14.0-alpine as service3
WORKDIR /usr/service/
COPY ./package.json .
RUN npm install
COPY . .
CMD [ "node", "service3.js" ]