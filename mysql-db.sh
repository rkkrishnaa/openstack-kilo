DBPASS=P@ssw0rd
KEYSTONE_DBPASS=P@ssw0rd
GLANCE_PASS=P@ssw0rd
NOVA_PASS=P@ssw0rd
NEUTRON_PASS=P@ssw0rd
CINDER_PASS=P@ssw0rd
HEAT_PASS=P@ssw0rd
CEILOMETER_PASS=P@ssw0rd
ADMIN_PASS=P@ssw0rd
DEMO_PASS=P@ssw0rd

echo "MYSQL Installation Started"
echo mariadb-server-5.5 mysql-server/root_password password ${DBPASS} | debconf-set-selections
echo mariadb-server-5.5 mysql-server/root_password_again password ${DBPASS} | debconf-set-selections
apt-get -y install mariadb-server python-mysqldb

touch /etc/mysql/conf.d/mysqld_openstack.cnf
crudini --set /etc/mysql/conf.d/mysqld_openstack.cnf mysqld bind-address 0.0.0.0
crudini --set /etc/mysql/conf.d/mysqld_openstack.cnf mysqld default-storage-engine innodb
echo "innodb_file_per_table" >> /etc/mysql/conf.d/mysqld_openstack.cnf
crudini --set /etc/mysql/conf.d/mysqld_openstack.cnf mysqld collation-server utf8_general_ci
crudini --set /etc/mysql/conf.d/mysqld_openstack.cnf mysqld init-connect "'SET NAMES utf8'"
crudini --set /etc/mysql/conf.d/mysqld_openstack.cnf mysqld character-set-server utf8
#sed -i '3 a innodb_file_per_table' /etc/mysql/conf.d/mysqld_openstack.cnf 
service mysql restart
echo "MYSQL Installation Completed!"

mysql -u root -p$DBPASS << EOF
CREATE DATABASE keystone;
CREATE DATABASE glance;
CREATE DATABASE nova;
CREATE DATABASE neutron;
CREATE DATABASE cinder;
CREATE DATABASE heat;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY '$KEYSTONE_DBPASS';
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY '$KEYSTONE_DBPASS';
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' IDENTIFIED BY '$GLANCE_DBPASS';
GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' IDENTIFIED BY '$GLANCE_DBPASS';
GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' IDENTIFIED BY '$NOVA_DBPASS';
GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' IDENTIFIED BY '$NOVA_DBPASS';
GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' IDENTIFIED BY '$NEUTRON_DBPASS';
GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' IDENTIFIED BY '$NEUTRON_DBPASS';
GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' IDENTIFIED BY '$CINDER_DBPASS';
GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' IDENTIFIED BY '$CINDER_DBPASS';
GRANT ALL PRIVILEGES ON heat.* TO 'heat'@'localhost' IDENTIFIED BY '$HEAT_DBPASS';
GRANT ALL PRIVILEGES ON heat.* TO 'heat'@'%' IDENTIFIED BY '$HEAT_DBPASS';
EOF
