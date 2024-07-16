#!/bin/bash

cd /tmp

apt-get update
apt-get install -y wget git

[ -f "mysqltuner.pl" ] || wget http://mysqltuner.pl/ -O mysqltuner.pl
[ -f "basic_passwords.txt" ] || wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/basic_passwords.txt -O basic_passwords.txt
[ -f "vulnerabilities.csv" ] || wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/vulnerabilities.csv -O vulnerabilities.csv
chmod u+x mysqltuner.pl

cd /tmp
git clone https://github.com/FromDual/mariadb-sys.git
cd /tmp/mariadb-sys/
mysql --user=root --password={{photoprism_root_password}} < ./sys_10.sql

# Run MySQLTuner.