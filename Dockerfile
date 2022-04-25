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

FROM        quay.io/prometheus/busybox:latest as prometheus
COPY prometheus                             /bin/prometheus
COPY promtool                               /bin/promtool
COPY documentation/examples/prometheus.yml  /etc/prometheus/prometheus.yml
COPY console_libraries/                     /etc/prometheus/
COPY consoles/                              /etc/prometheus/
EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "-config.file=/etc/prometheus/prometheus.yml", \
             "-storage.local.path=/prometheus", \
             "-web.console.libraries=/etc/prometheus/console_libraries", \
             "-web.console.templates=/etc/prometheus/consoles" ]

