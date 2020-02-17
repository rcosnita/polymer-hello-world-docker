FROM node:12.14.1-buster-slim as build_frontend

ADD package.json /home/example/package.json

WORKDIR /home/example
RUN npm install polymer-cli && \
    npm install -d

ADD . /home/example
RUN ./node_modules/.bin/polymer build

FROM nginx:1.17.8

WORKDIR /usr/share/nginx/html
COPY --from=build_frontend /home/example/build/default .
COPY --from=build_frontend /home/example/manifest.json manifest.json