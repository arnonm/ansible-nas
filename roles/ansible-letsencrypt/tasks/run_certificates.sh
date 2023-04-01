sudo docker run -it --rm \
        -v /docker-volumes/etc/letsencrypt:/etc/letsencrypt \
        -v /docker-volumes/var/lib/letsencrypt:/var/lib/letsencrypt \
        -v $PWD/html:/data/letsencrypt \
        -v /docker-volumes/var/log/letsencrypt:/var/log/letsencrypt \
        certbot/certbot -v\
        certonly --webroot \
        --email {{ansible_nas_email}} \
        --agree-tos --no-eff-email \
        --webroot-path=/data/letsencrypt \
        -d {{ansible_nas_dns}}
~
~