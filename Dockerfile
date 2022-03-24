FROM node:12-alpine AS build
WORKDIR /usr/src/app
COPY package*.json /usr/src/app/
COPY yarn.lock /usr/src/app/
# RUN --mount=type=secret,mode=0644,id=npmrc,target=/usr/src/app/.npmrc yarn install --frozen-lockfile
RUN yarn install --frozen-lockfile

FROM node:12-alpine
RUN apk add dumb-init
ENV NODE_ENV production
USER node
WORKDIR /usr/src/app
COPY --chown=node:node --from=build /usr/src/app/node_modules /usr/src/app/node_modules
COPY --chown=node:node . /usr/src/app

EXPOSE 5000

CMD ["dumb-init", "node", "index.js"]