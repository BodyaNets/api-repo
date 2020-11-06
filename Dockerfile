# syntax = docker/dockerfile:1.0-experimental
FROM node:latest as debug
WORKDIR /app

COPY ./dist /app/dist

COPY ./tsconfig.json /app
COPY package.json /app
COPY package-lock.json /app


RUN --mount=type=secret,id=npmrc,dst=/app/.npmrc npm i
RUN npm i -g nodemon

VOLUME /app/src

ENTRYPOINT ["nodemon", "--inspect=0.0.0.0", "./dist/index.js"]


# syntax = docker/dockerfile:1.0-experimental
FROM node:latest as prod
WORKDIR /app
COPY ./dist /app
COPY ./tsconfig.json /app
COPY package.json /app
COPY package-lock.json /app
RUN --mount=type=secret,id=npmrc,dst=/app/.npmrc npm i
CMD ["node", "./index.js"]