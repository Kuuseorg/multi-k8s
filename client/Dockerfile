FROM node:alpine AS builder
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .
CMD npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /app/build /usr/share/nginx/html
