#FROM nginx:alpine
FROM nextcloud:apache

RUN apt-get update && apt-get install -y procps smbclient && rm -rf /var/lib/apt/lists/*


# FROM nextcloud:fpm-alpine

# COPY nginx.conf /etc/nginx/nginx.conf
# RUN apk add --no-cache procps samba-client