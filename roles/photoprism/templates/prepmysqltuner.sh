
docker exec -i photoprism_mariadb /docker-entrypoint-initdb.d/mysqltuner.sh
docker exec -i photoprism_mariadb /tmp/mysqltuner.pl --user=root --password={{photoprism_root_password}}
