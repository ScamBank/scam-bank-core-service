FROM node:22-alpine

RUN apk add --no-cache yarn

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

RUN yarn install --production --ignore-scripts --prefer-offline

EXPOSE 3000

CMD ["node", "dist/main"]