FROM nginx:latest

EXPOSE 8080

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./.htpasswd /etc/nginx/.htpasswd
COPY ./security.conf /etc/nginx/security.conf