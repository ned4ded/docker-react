FROM node:alpine as build

WORKDIR /app

COPY . . 

RUN npm install

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

CMD /bin/sh -c "envsubst '\$PORT' < ./etc/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'