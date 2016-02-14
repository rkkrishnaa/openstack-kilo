#!/bin/bash
############################################################################
#About Author 
#Radhakrishnan Rk 
#Openstack Engineer
#Cloudenablers, Chennai, India
############################################################################
#About Script
#This shell script deploys openstack kilo all in one setup in 
#your physical/virtual machine Ubuntu 14.04 LTS Operating System installed.
#This script is recommended for testing and provisioning openstack kilo and 
#provisioning VM in your lab environment.
############################################################################
#Obtain input variables from user
echo "Enter controller/compute/network node management ip"
read -r MGMT_IP
echo "Enter pubic url ip"
read -r PUBLIC_URL_IP
echo "Enter internal url ip"
read -r INTERNAL_URL_IP
echo "Enter admin url ip"
read -r ADMIN_URL_IP
echo "Enter public url domain name"
read -r PUBLIC_URL_DOMAIN_NAME
echo "Enter internal url domain name "
read -r INTERNAL_URL_DOMAIN_NAME
echo "Enter admin url domain name"
read -r ADMIN_URL_DOMAIN_NAME
echo "Enter public interface name"
read -r PUBLIC_INTERFACE_NAME
echo "Enter overlay interface ip address"
read -r OVERLAY_INTERFACE_IP_ADDRESS
echo "Enter admin user password"
read -r ADMIN_PASS
echo "Enter demo user password"
read -r DEMO_PASS
echo "Enter root user DB password"
read -r DBPASS
echo "Enter openstack user rabbitmq password"
read -r RABBIT_PASS
echo "Enter keystone DB password"
read -r KEYSTONE_DBPASS
echo "Enter glance DB password"
read -r GLANCE_DBPASS
echo "Enter nova DB password"
read -r NOVA_DBPASS
echo "Enter neutron DB password"
read -r NEUTRON_DBPASS
echo "Enter cinder DB password"
read -r CINDER_DBPASS
echo "Enter heat DB password"
read -r HEAT_DBPASS
echo "Enter ceilometer DB password" 
read -r CEILOMETER_DBPASS
echo "Enter glance user password"
read -r GLANCE_PASS
echo "Enter nova user password"
read -r NOVA_PASS
echo "Enter neutron user password"
read -r NEUTRON_PASS
echo "Enter cinder user password"
read -r CINDER_PASS
echo "Enter heat user password"
read -r HEAT_PASS
echo "Enter ceilometer user password"
read -r CEILOMETER_PASS
echo "Enter openstack domain"
read -r DOMAIN
echo "Enter openstack region"
read -r REGION
echo "Enter user domain id"
read -r USER_DOMAIN_ID 
echo "Enter user project id"
read -r PROJECT_DOMAIN_ID
echo "Thank you!! Openstack Deployment Started!!"
#Variable Declaration
#IP and Domain Variables
MGMT_IP=$MGMT_IP
PUBLIC_URL_IP=$PUBLIC_URL_IP
INTERNAL_URL_IP=$INTERNAL_URL_IP
ADMIN_URL_IP=$ADMIN_URL_IP
PUBLIC_URL_DOMAIN_NAME=$PUBLIC_URL_DOMAIN_NAME
INTERNAL_URL_DOMAIN_NAME=$INTERNAL_URL_DOMAIN_NAME
ADMIN_URL_DOMAIN_NAME=$ADMIN_URL_DOMAIN_NAME
PUBLIC_INTERFACE_NAME=$PUBLIC_INTERFACE_NAME
OVER_LAY_INTERFACE_IP_ADDRESS=$OVERLAY_INTERFACE_IP_ADDRESS
DOMAIN=$DOMAIN
REGION=$REGION
USER_DOMAIN_ID=$PROJECT_DOMAIN_ID
PROJECT_DOMAIN_ID=$PROJECT_DOMAIN_ID
#DB Passwords
DBPASS=$DBPASS
KEYSTONE_DBPASS=$KEYSTONE_DBPASS
GLANCE_DBPASS=$GLANCE_DBPASS
NOVA_DBPASS=$NOVA_DBPASS
NEUTRON_DBPASS=$NEUTRON_DBPASS
CINDER_DBPASS=$CINDER_DBPASS
HEAT_DBPASS=$HEAT_DBPASS
CEILOMETER_DBPASS=$CEILOMETER_DBPASS
#Rabbit MQ Password
RABBIT_PASS=$RABBIT_PASS
#Openstack User Passwords
GLANCE_PASS=$GLANCE_PASS
NOVA_PASS=$NOVA_PASS
NEUTRON_PASS=$NEUTRON_PASS
CINDER_PASS=$CINDER_PASS
HEAT_PASS=$HEAT_PASS
CEILOMETER_PASS=$CEILOMETER_PASS
ADMIN_PASS=$ADMIN_PASS
DEMO_PASS=$DEMO_PASS
touch /root/input.txt
echo "MGMT_IP='$MGMT_IP'" >> /root/input.txt
echo "PUBLIC_URL_IP='$PUBLIC_URL_IP'" >> /root/input.txt
echo "INTERNAL_URL_IP='$INTERNAL_URL_IP'" >> /root/input.txt
echo "ADMIN_URL_IP='$ADMIN_URL_IP'" >> /root/input.txt  
echo "PUBLIC_URL_DOMAIN_NAME='$PUBLIC_URL_DOMAIN_NAME'" >> /root/input.txt
echo "INTERNAL_URL_DOMAIN_NAME='$INTERNAL_URL_DOMAIN_NAME'" >> /root/input.txt
echo "ADMIN_URL_DOMAIN_NAME='$ADMIN_URL_DOMAIN_NAME'" >> /root/input.txt
echo "PUBLIC_INTERFACE_NAME='$PUBLIC_INTERFACE_NAME'" >> /root/input.txt
echo "OVER_LAY_INTERFACE_IP_ADDRESS='$OVERLAY_INTERFACE_IP_ADDRESS'" >> /root/input.txt
echo "DOMAIN='$DOMAIN'" >> /root/input.txt
echo "REGION='$REGION'" >> /root/input.txt
echo "USER_DOMAIN_ID='$PROJECT_DOMAIN_ID'" >> /root/input.txt
echo "PROJECT_DOMAIN_ID='$PROJECT_DOMAIN_ID'" >> /root/input.txt
echo "DBPASS='$DBPASS'" >> /root/input.txt
echo "KEYSTONE_DBPASS='$KEYSTONE_DBPASS'" >> /root/input.txt
echo "GLANCE_DBPASS='$GLANCE_DBPASS'" >> /root/input.txt
echo "NOVA_DBPASS='$NOVA_DBPASS'" >> /root/input.txt
echo "NEUTRON_DBPASS='$NEUTRON_DBPASS'" >> /root/input.txt
echo "CINDER_DBPASS='$CINDER_DBPASS'" >> /root/input.txt
echo "HEAT_DBPASS='$HEAT_DBPASS'" >> /root/input.txt
echo "CEILOMETER_DBPASS='$CEILOMETER_DBPASS'" >> /root/input.txt
echo "RABBIT_PASS='$RABBIT_PASS'" >> /root/input.txt
echo "GLANCE_PASS='$GLANCE_PASS'" >> /root/input.txt
echo "NOVA_PASS='$NOVA_PASS'" >> /root/input.txt
echo "NEUTRON_PASS='$NEUTRON_PASS'" >> /root/input.txt
echo "CINDER_PASS='$CINDER_PASS'" >> /root/input.txt
echo "HEAT_PASS='$HEAT_PASS'" >> /root/input.txt
echo "CEILOMETER_PASS='$CEILOMETER_PASS'" >> /root/input.txt
echo "ADMIN_PASS='$ADMIN_PASS'" >> /root/input.txt
echo "DEMO_PASS='$DEMO_PASS'" >> /root/input.txt


#Host and IP Address mappings in /etc/hosts file 
echo "$MGMT_IP controller" >> /etc/hosts
echo "$PUBLIC_URL_IP $PUBLIC_URL_DOMAIN_NAME" >> /etc/hosts
echo "$INTERNAL_URL_IP $INTERNAL_URL_DOMAIN_NAME" >> /etc/hosts
echo "$ADMIN_URL_IP $ADMIN_URL_DOMAIN_NAME" >> /etc/hosts
#Basic Software Installation
export DEBIAN_FRONTEND=noninteractive
function ospackages() {
apt-get -y update && apt-get -y dist-upgrade
apt-get -y install crudini
#OpenStack packages
echo "Openstack Packages Installation Started"
apt-get -y install ubuntu-cloud-keyring
echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" "trusty-updates/kilo main" > /etc/apt/sources.list.d/cloudarchive-kilo.list
apt-get -y update && apt-get -y dist-upgrade
echo "Openstack Packages Installation Completed"
}

#SQL database
function mysqlDB() {
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
}
#Create DB for openstack services
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
echo "Openstack Service DB Creation Completed!"

#MongoDB database 
function mongoDB() {
echo "MongoDB Installation Started"
apt-get -y install mongodb-server mongodb-clients python-pymongo
sed -i '3 a smallfiles = true' /etc/mongodb.conf
sed -i '3 a bind_ip = 10.0.0.11' /etc/mongodb.conf
service mongodb stop
rm /var/lib/mongodb/journal/prealloc.*
service mongodb start
mongo --host controller --eval 'db = db.getSiblingDB("ceilometer");db.addUser({user: "ceilometer",pwd: "$CEILOMETER_DBPASS",roles: [ "readWrite", "dbAdmin" ]})'
echo "MongoDB Installation Completed!"
}

#Message queue RabbitMQ
function rabbitMQ() {
apt-get -y install rabbitmq-server
rabbitmqctl add_user openstack $RABBIT_PASS
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
echo "RabbitMQ Installation Completed!"
}

cd /root
touch admin-openrc.sh demo-openrc.sh
echo "export OS_PROJECT_DOMAIN_ID=$PROJECT_DOMAIN_ID"             | tee -a admin-openrc.sh demo-openrc.sh
echo "export OS_USER_DOMAIN_ID=$USER_DOMAIN_ID"                   | tee -a admin-openrc.sh demo-openrc.sh
echo "export OS_PROJECT_NAME=admin"                               | tee -a admin-openrc.sh 
echo "export OS_TENANT_NAME=admin"                                | tee -a admin-openrc.sh 
echo "export OS_USERNAME=admin"                                   | tee -a admin-openrc.sh 
echo "export OS_PASSWORD=$ADMIN_PASS"                             | tee -a admin-openrc.sh
echo "export OS_PROJECT_NAME=demo"	                              | tee -a demo-openrc.sh
echo "export OS_TENANT_NAME=demo"                                 | tee -a demo-openrc.sh
echo "export OS_USERNAME=demo"             	                      | tee -a demo-openrc.sh
echo "export OS_PASSWORD=$DEMO_PASS"                              | tee -a demo-openrc.sh
echo "export OS_AUTH_URL=http://$PUBLIC_URL_DOMAIN_NAME:35357/v3" | tee -a admin-openrc.sh
echo "export OS_AUTH_URL=http://$PUBLIC_URL_DOMAIN_NAME:5000/v3"  | tee -a demo-openrc.sh
echo "export OS_IMAGE_API_VERSION=2"                              | tee -a admin-openrc.sh demo-openrc.sh
echo "export OS_VOLUME_API_VERSION=2"                             | tee -a admin-openrc.sh demo-openrc.sh

#Keystone
function keystone() {
echo "Keystone Installation Started"
ADMIN_TOKEN=$(openssl rand -hex 10)
echo $ADMIN_TOKEN
echo "manual" > /etc/init/keystone.override
apt-get -y install keystone python-openstackclient apache2 \
libapache2-mod-wsgi memcached python-memcache

crudini --set /etc/keystone/keystone.conf DEFAULT verbose True
crudini --set /etc/keystone/keystone.conf DEFAULT admin_token $ADMIN_TOKEN
crudini --set /etc/keystone/keystone.conf database connection mysql://keystone:$KEYSTONE_DBPASS@controller/keystone
crudini --set /etc/keystone/keystone.conf memcache servers localhost:11211
crudini --set /etc/keystone/keystone.conf token provider keystone.token.providers.uuid.Provider
crudini --set /etc/keystone/keystone.conf token driver keystone.token.persistence.backends.memcache.Token
crudini --set /etc/keystone/keystone.conf revoke driver keystone.contrib.revoke.backends.sql.Revoke
echo "Keystone DB Sync"
su -s /bin/sh -c "keystone-manage db_sync" keystone
echo "Apache HTTP server Configuration"
touch /etc/apache2/sites-available/wsgi-keystone.conf
echo "Listen 5000" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "Listen 35357" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "<VirtualHost *:5000>" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone display-name=%{GROUP}" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIProcessGroup keystone-public" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIScriptAlias / /var/www/cgi-bin/keystone/main" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIApplicationGroup %{GLOBAL}" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIPassAuthorization On" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "<IfVersion >= 2.4>" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo 'ErrorLogFormat "%{cu}t %M"' >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "</IfVersion>" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "LogLevel info" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "ErrorLog /var/log/apache2/keystone-error.log" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "CustomLog /var/log/apache2/keystone-access.log combined" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/wsgi-keystone.conf

echo "<VirtualHost *:35357>" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone display-name=%{GROUP}" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIProcessGroup keystone-admin" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIScriptAlias / /var/www/cgi-bin/keystone/admin" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIApplicationGroup %{GLOBAL}" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "WSGIPassAuthorization On" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "<IfVersion >= 2.4>" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo 'ErrorLogFormat "%{cu}t %M"' >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "</IfVersion>" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "LogLevel info" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "ErrorLog /var/log/apache2/keystone-error.log" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "CustomLog /var/log/apache2/keystone-access.log combined" >> /etc/apache2/sites-available/wsgi-keystone.conf
echo "</VirtualHost>" >> /etc/apache2/sites-available/wsgi-keystone.conf
     
ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled
mkdir -p /var/www/cgi-bin/keystone
touch /var/www/cgi-bin/keystone/main 
touch /var/www/cgi-bin/keystone/admin
echo "import os" >> /var/www/cgi-bin/keystone/main
echo "from keystone.server import wsgi as wsgi_server" >> /var/www/cgi-bin/keystone/main
echo "name = os.path.basename(__file__)" >> /var/www/cgi-bin/keystone/main
echo "application = wsgi_server.initialize_application(name)" >> /var/www/cgi-bin/keystone/main
cp /var/www/cgi-bin/keystone/main /var/www/cgi-bin/keystone/admin
chown -R keystone:keystone /var/www/cgi-bin/keystone
chmod 755 /var/www/cgi-bin/keystone/*

service apache2 restart
rm -f /var/lib/keystone/keystone.db
echo "Openstack Service,User,Project,Role,Endpoint Creation"
export OS_TOKEN=$b
export OS_URL=http://$ADMIN_URL_DOMAIN_NAME:35357/v2.0

openstack service create --name keystone --description "OpenStack Identity" identity
openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:5000/v2.0 \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:5000/v2.0 \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:35357/v2.0 \
--region $REGION identity
openstack project create --description "Admin Project" admin
openstack project create --description "Demo Project" demo
openstack project create --description "Service Project" service
openstack user create --password $ADMIN_PASS admin
openstack user create --password $DEMO_PASS demo
openstack role create admin
openstack role create user
openstack role create heat_stack_owner
openstack role create heat_stack_user

openstack role add --project admin --user admin admin
openstack role add --project demo  --user demo user

export OS_PROJECT_DOMAIN_ID=$PROJECT_DOMAIN_ID
export OS_USER_DOMAIN_ID=$USER_DOMAIN_ID
export OS_PROJECT_NAME=admin                        
export OS_TENANT_NAME=admin     
export OS_IMAGE_API_VERSION=2
export OS_VOLUME_API_VERSION=2
#Create Users
openstack user create --password $GLANCE_PASS  glance
openstack user create --password $NOVA_PASS    nova
openstack user create --password $NEUTRON_PASS neutron
openstack user create --password $CINDER_PASS  cinder
openstack user create --password $HEAT_PASS    heat
openstack user create --password $CEILOMETER_PASS ceilometer
#Add the admin role to the users and service project
openstack role add --project service --user glance  admin
openstack role add --project service --user nova    admin
openstack role add --project service --user neutron admin
openstack role add --project service --user cinder  admin
openstack role add --project service --user heat    admin
openstack role add --project service --user ceilometer admin
openstack role add --project demo --user demo heat_stack_owner

#Create Service entities
openstack service create --name glance     --description "OpenStack Image service" image
openstack service create --name nova       --description "OpenStack Compute"       compute
openstack service create --name neutron    --description "OpenStack Networking"    network
openstack service create --name heat       --description "Orchestration"           orchestration
openstack service create --name heat-cfn   --description "Orchestration"		   cloudformation
openstack service create --name cinder     --description "Openstack Block Storage" volume
openstack service create --name cinderv2   --description "Openstack Block Storage" volumev2
openstack service create --name ceilometer --description "Telemetry"               metering
#Create Service API endpoints
#glance api endpoints
openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:9292 \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:9292 \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:9292 \
--region $REGION image
#nova api endpoints
openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:8774/v2/%\(tenant_id\)s \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:8774/v2/%\(tenant_id\)s \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:8774/v2/%\(tenant_id\)s \
--region $REGION compute 

#neutron api endpoints
openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:9696 \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:9696 \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:9696 \
--region $REGION network    

#heat api endpoints
openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:8004/v1/%\(tenant_id\)s \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:8004/v1/%\(tenant_id\)s \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:8004/v1/%\(tenant_id\)s \
--region $REGION orchestration

openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:8000/v1 \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:8000/v1 \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:8000/v1 \
--region $REGION cloudformation

#cinder api endpoints
openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:8776/v2/%\(tenant_id\)s \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:8776/v2/%\(tenant_id\)s \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:8776/v2/%\(tenant_id\)s \
--region $REGION volume

openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:8776/v2/%\(tenant_id\)s
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:8776/v2/%\(tenant_id\)s \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:8776/v2/%\(tenant_id\)s \
--region $REGION volumev2

#ceilometer api endpoints
openstack endpoint create \
--publicurl http://$PUBLIC_URL_DOMAIN_NAME:8777 \
--internalurl http://$INTERNAL_URL_DOMAIN_NAME:8777 \
--adminurl http://$ADMIN_URL_DOMAIN_NAME:8777 \
--region $REGION metering

echo "Openstack Keystone Configuration Completed"
}

#Glance	
function glance() { 
echo "Openstack Glance Installation Started"
apt-get -y install glance python-glanceclient
echo "Openstack Glance API Configuration"
crudini --set /etc/glance/glance-api.conf DEFAULT notification_driver messagingv2
crudini --set /etc/glance/glance-api.conf DEFAULT rpc_backend rabbit
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_host controller
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_userid openstack
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_password $RABBIT_PASS
crudini --set /etc/glance/glance-api.conf DEFAULT verbose True
crudini --set /etc/glance/glance-api.conf database connection mysql://glance:$GLANCE_DBPASS@controller/glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_url http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/glance/glance-api.conf keystone_authtoken auth_plugin password
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_domain_id $USER_DOMAIN_ID
crudini --set /etc/glance/glance-api.conf keystone_authtoken user_domain_id $USER_DOMAIN_ID
crudini --set /etc/glance/glance-api.conf keystone_authtoken project_name service
crudini --set /etc/glance/glance-api.conf keystone_authtoken username glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken password $GLANCE_PASS
crudini --set /etc/glance/glance-api.conf paste_deploy flavor keystone
crudini --set /etc/glance/glance-api.conf glance_store default_store file
crudini --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir /var/lib/glance/images/
echo "Openstack Glance Registry Configuration"
crudini --set /etc/glance/glance-registry.conf DEFAULT notification_driver messagingv2
crudini --set /etc/glance/glance-registry.conf DEFAULT rpc_backend rabbit
crudini --set /etc/glance/glance-registry.conf DEFAULT rabbit_host controller
crudini --set /etc/glance/glance-registry.conf DEFAULT rabbit_userid openstack
crudini --set /etc/glance/glance-registry.conf DEFAULT rabbit_password $RABBIT_PASS
crudini --set /etc/glance/glance-registry.conf DEFAULT verbose True
crudini --set /etc/glance/glance-registry.conf database connection mysql://glance:$GLANCE_DBPASS@controller/glance
crudini --set /etc/glance/glance-registry.conf keystone_authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000
crudini --set /etc/glance/glance-registry.conf keystone_authtoken auth_url http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/glance/glance-registry.conf keystone_authtoken auth_plugin password
crudini --set /etc/glance/glance-registry.conf keystone_authtoken project_domain_id $PROJECT_DOMAIN_ID
crudini --set /etc/glance/glance-registry.conf keystone_authtoken user_domain_id $USER_DOMAIN_ID
crudini --set /etc/glance/glance-registry.conf keystone_authtoken project_name service
crudini --set /etc/glance/glance-registry.conf keystone_authtoken username glance
crudini --set /etc/glance/glance-registry.conf keystone_authtoken password $GLANCE_PASS
crudini --set /etc/glance/glance-registry.conf paste_deploy flavor keystone
echo "Glance DB Sync"
su -s /bin/sh -c "glance-manage db_sync" glance
service glance-registry restart
service glance-api restart
rm -f /var/lib/glance/glance.sqlite
echo "Openstack Glance Installation Completed"
}

#Nova
function nova() {
echo "Openstack Nova Installation Started"
apt-get -y install nova-api nova-cert nova-conductor nova-consoleauth nova-novncproxy nova-scheduler nova-compute sysfsutils python-novaclient
crudini --set /etc/nova/nova.conf database connection mysql://nova:$NOVA_DBPASS@controller/nova
crudini --set /etc/nova/nova.conf DEFAULT verbose True
crudini --set /etc/nova/nova.conf DEFAULT rpc_backend rabbit
crudini --set /etc/nova/nova.conf DEFAULT auth_strategy keystone
crudini --set /etc/nova/nova.conf DEFAULT enabled_apis osapi_compute,metadata
crudini --set /etc/nova/nova.conf DEFAULT my_ip $MGMT_IP
crudini --set /etc/nova/nova.conf DEFAULT network_api_class nova.network.neutronv2.api.API
crudini --set /etc/nova/nova.conf DEFAULT security_group_api neutron
crudini --set /etc/nova/nova.conf DEFAULT linuxnet_interface_driver nova.network.linux_net.NeutronOVSInterfaceDriver
crudini --set /etc/nova/nova.conf DEFAULT firewall_driver nova.virt.firewall.NoopFirewallDriver
crudini --set /etc/nova/nova.conf DEFAULT vnc_enabled True
crudini --set /etc/nova/nova.conf DEFAULT vncserver_listen 0.0.0.0
crudini --set /etc/nova/nova.conf DEFAULT vncserver_proxyclient_address $MGMT_IP
crudini --set /etc/nova/nova.conf DEFAULT novncproxy_base_url http://$PUBLIC_URL_DOMAIN_NAME:6080/vnc_auto.html
crudini --set /etc/nova/nova.conf DEFAULT instance_usage_audit True
crudini --set /etc/nova/nova.conf DEFAULT instance_usage_audit_period hour
crudini --set /etc/nova/nova.conf DEFAULT notify_on_state_change vm_and_task_state
crudini --set /etc/nova/nova.conf DEFAULT notification_driver messagingv2
crudini --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_host controller
crudini --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_userid openstack
crudini --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_password $RABBIT_PASS
crudini --set /etc/nova/nova.conf keystone_authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000
crudini --set /etc/nova/nova.conf keystone_authtoken auth_url http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/nova/nova.conf keystone_authtoken auth_plugin password
crudini --set /etc/nova/nova.conf keystone_authtoken project_domain_id $PROJECT_DOMAIN_ID
crudini --set /etc/nova/nova.conf keystone_authtoken user_domain_id $USER_DOMAIN_ID
crudini --set /etc/nova/nova.conf keystone_authtoken project_name service
crudini --set /etc/nova/nova.conf keystone_authtoken username nova
crudini --set /etc/nova/nova.conf keystone_authtoken password $NOVA_PASS
crudini --set /etc/nova/nova.conf glance host controller
crudini --set /etc/nova/nova.conf oslo_concurrency lock_path /var/lib/nova/tmp
crudini --set /etc/nova/nova.conf neutron url http://$ADMIN_URL_DOMAIN_NAME:9696
crudini --set /etc/nova/nova.conf neutron admin_auth_url http://$ADMIN_URL_DOMAIN_NAME:35357/v2.0
crudini --set /etc/nova/nova.conf neutron auth_strategy keystone
crudini --set /etc/nova/nova.conf neutron admin_tenant_name service
crudini --set /etc/nova/nova.conf neutron admin_username neutron
crudini --set /etc/nova/nova.conf neutron admin_password $NEUTRON_PASS
crudini --set /etc/nova/nova.conf neutron service_metadata_proxy True
crudini --set /etc/nova/nova.conf neutron nova_metadata_ip 127.0.0.1
crudini --set /etc/nova/nova.conf neutron metadata_proxy_shared_secret METADATA_SECRET
echo "Nova DB Sync"
su -s /bin/sh -c "nova-manage db sync" nova
service nova-api restart
service nova-cert restart
service nova-consoleauth restart
service nova-scheduler restart
service nova-conductor restart
service nova-novncproxy restart

rm -f /var/lib/nova/nova.sqlite

echo "Your cpu info" 
cpuinfo=$(egrep -c '(vmx|svm)' /proc/cpuinfo)
echo $cpuinfo
if [ $cpuinfo != 0 ]
then
	echo "Your hardware supports virtualization"
	crudini --set /etc/nova/nova-compute.conf libvirt virt_type kvm
else
	echo "Your hardware does supports virtualization"
	crudini --set /etc/nova/nova-compute.conf libvirt virt_type qemu
fi 
echo "Openstack Nova Installation Completed"
}

#Neutron
function neutron() {
echo "Openstack Neutron Installation Started"
echo "net.ipv4.conf.all.rp_filter=0" >> /etc/sysctl.conf 
echo "net.ipv4.conf.default.rp_filter=0" >> /etc/sysctl.conf 
echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf 
echo "net.bridge.bridge-nf-call-ip6tables=1" >> /etc/sysctl.conf 
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf 
echo "net.ipv4.conf.all.rp_filter=0" >> /etc/sysctl.conf 
echo "net.ipv4.conf.default.rp_filter=0" >> /etc/sysctl.conf 

apt-get -y install neutron-server neutron-plugin-ml2 neutron-plugin-openvswitch-agent neutron-l3-agent \
neutron-dhcp-agent neutron-metadata-agent python-neutronclient 
echo "Neutron Server Configuration"
crudini --set /etc/neutron/neutron.conf DEFAULT verbose True
crudini --set /etc/neutron/neutron.conf DEFAULT rpc_backend rabbit
crudini --set /etc/neutron/neutron.conf DEFAULT auth_strategy keystone
crudini --set /etc/neutron/neutron.conf DEFAULT core_plugin ml2
crudini --set /etc/neutron/neutron.conf DEFAULT service_plugins router
crudini --set /etc/neutron/neutron.conf DEFAULT allow_overlapping_ips True
crudini --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_status_changes True
crudini --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_data_changes True
crudini --set /etc/neutron/neutron.conf DEFAULT nova_url http://$ADMIN_URL_DOMAIN_NAME:8774/v2
crudini --set /etc/neutron/neutron.conf database connection mysql://neutron:$NEUTRON_DBPASS@controller/neutron
crudini --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_host  controller
crudini --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_userid  openstack
crudini --set /etc/neutron/neutron.conf oslo_messaging_rabbit rabbit_password  $RABBIT_PASS
crudini --set /etc/neutron/neutron.conf keystone_authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000
crudini --set /etc/neutron/neutron.conf keystone_authtoken auth_url http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/neutron/neutron.conf keystone_authtoken auth_plugin password
crudini --set /etc/neutron/neutron.conf keystone_authtoken project_domain_id $PROJECT_DOMAIN_ID
crudini --set /etc/neutron/neutron.conf keystone_authtoken user_domain_id $USER_DOMAIN_ID
crudini --set /etc/neutron/neutron.conf keystone_authtoken project_name service
crudini --set /etc/neutron/neutron.conf keystone_authtoken username neutron
crudini --set /etc/neutron/neutron.conf keystone_authtoken password $NEUTRON_PASS
crudini --set /etc/neutron/neutron.conf nova auth_url http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/neutron/neutron.conf nova auth_plugin password
crudini --set /etc/neutron/neutron.conf nova project_domain_id $PROJECT_DOMAIN_ID
crudini --set /etc/neutron/neutron.conf nova user_domain_id $USER_DOMAIN_ID
crudini --set /etc/neutron/neutron.conf nova region_name $REGION
crudini --set /etc/neutron/neutron.conf nova project_name service
crudini --set /etc/neutron/neutron.conf nova username nova
crudini --set /etc/neutron/neutron.conf nova password $NOVA_PASS
echo "Neutron Modular Layer2 Plugin Configuration"
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 type_drivers flat,vlan,gre,vxlan
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 tenant_network_types gre
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2 mechanism_drivers openvswitch
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_flat flat_networks external
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ml2_type_gre tunnel_id_ranges 1:1000
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini securitygroup enable_security_group True
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini securitygroup enable_ipset True
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini securitygroup firewall_driver neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ovs local_ip $OVERLAY_INTERFACE_IP_ADDRESS
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini ovs bridge_mappings external:br-ex
crudini --set /etc/neutron/plugins/ml2/ml2_conf.ini agent tunnel_types gre

echo "Neutron DB Sync"
su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

service nova-api restart
service neutron-server restart
rm -f /var/lib/neutron/neutron.sqlite

service openvswitch-switch restart
service nova-compute restart
service neutron-plugin-openvswitch-agent restart
echo "Neutron Layer-3 agent Configuration"
crudini --set /etc/neutron/l3_agent.ini DEFUALT interface_driver neutron.agent.linux.interface.OVSInterfaceDriver
crudini --set /etc/neutron/l3_agent.ini DEFAULT external_network_bridge '='
crudini --set /etc/neutron/l3_agent.ini DEFAULT router_delete_namespaces True
crudini --set /etc/neutron/l3_agent.ini DEFAULT verbose True
echo "Neutron DHCP Agent Configuration"
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT interface_driver neutron.agent.linux.interface.OVSInterfaceDriver
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT dhcp_driver neutron.agent.linux.dhcp.Dnsmasq
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT dhcp_delete_namespaces True
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT verbose True
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT dnsmasq_config_file /etc/neutron/dnsmasq-neutron.conf
touch /etc/neutron/dnsmasq-neutron.conf
echo "dhcp-option-force=26,1454" >> /etc/neutron/dnsmasq-neutron.conf
pkill dnsmasq
echo "Neutron Metadata Agent Configuration "
crudini --set /etc/neutron/metadata_agent.ini DEFAULT auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000
crudini --set /etc/neutron/metadata_agent.ini DEFAULT auth_url http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/neutron/metadata_agent.ini DEFAULT auth_region $REGION
crudini --set /etc/neutron/metadata_agent.ini DEFAULT auth_plugin password
crudini --set /etc/neutron/metadata_agent.ini DEFAULT project_domain_id default
crudini --set /etc/neutron/metadata_agent.ini DEFAULT user_domain_id default
crudini --set /etc/neutron/metadata_agent.ini DEFAULT project_name service
crudini --set /etc/neutron/metadata_agent.ini DEFAULT username neutron
crudini --set /etc/neutron/metadata_agent.ini DEFAULT password $NEUTRON_PASS
crudini --set /etc/neutron/metadata_agent.ini DEFAULT nova_metadata_ip controller
crudini --set /etc/neutron/metadata_agent.ini DEFAULT metadata_proxy_shared_secret METADATA_SECRET
crudini --set /etc/neutron/metadata_agent.ini DEFAULT verbose True

service nova-compute restart
service nova-api restart
service neutron-plugin-linuxbridge-agent restart
service openvswitch-switch restart
echo "Brigde configs!!!!"
ovs-vsctl add-br br-ex
#ovs-vsctl add-port br-ex INTERFACE_NAME

service neutron-plugin-openvswitch-agent restart
service neutron-l3-agent restart
service neutron-dhcp-agent restart
service neutron-metadata-agent restart
echo "Openstack Neutron Installation Completed"
}

#Horizon
function horizon() {
echo "Openstack dashboard Installation Started"
apt-get -y install openstack-dashboard
apt-get -y remove --auto-remove openstack-dashboard-ubuntu-theme
echo "Openstack dashboard Installation Completed"
}

#Heat
function heat() {
echo "Openstack Heat Installation Started"
apt-get -y install heat-api heat-api-cfn heat-engine python-heatclient
crudini --set /etc/heat/heat.conf DEFAULT verbose True
crudini --set /etc/heat/heat.conf DEFAULT rpc_backend rabbit
crudini --set /etc/heat/heat.conf DEFAULT heat_metadata_server_url http://$ADMIN_URL_DOMAIN_NAME:8000
crudini --set /etc/heat/heat.conf DEFAULT heat_waitcondition_server_url http://$ADMIN_URL_DOMAIN_NAME:8000/v1/waitcondition
crudini --set /etc/heat/heat.conf DEFAULT stack_domain_admin heat_domain_admin
crudini --set /etc/heat/heat.conf DEFAULT stack_domain_admin_password HEAT_DOMAIN_PASS
crudini --set /etc/heat/heat.conf DEFAULT stack_user_domain_name heat_user_domain
crudini --set /etc/heat/heat.conf database connection mysql://heat:$HEAT_DBPASS@controller/heat
crudini --set /etc/heat/heat.conf oslo_messaging_rabbit rabbit_host controller
crudini --set /etc/heat/heat.conf oslo_messaging_rabbit rabbit_userid openstack
crudini --set /etc/heat/heat.conf oslo_messaging_rabbit rabbit_password $RABBIT_PASS
crudini --set /etc/heat/heat.conf keystone_authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000/v2.0
crudini --set /etc/heat/heat.conf keystone_authtoken identity_uri http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/heat/heat.conf keystone_authtoken admin_tenant_name service
crudini --set /etc/heat/heat.conf keystone_authtoken admin_user heat
crudini --set /etc/heat/heat.conf keystone_authtoken admin_password $HEAT_PASS
crudini --set /etc/heat/heat.conf ec2authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000/v2.0
heat-keystone-setup-domain \
--stack-user-domain-name heat_user_domain \
--stack-domain-admin heat_domain_admin \
--stack-domain-admin-password HEAT_DOMAIN_PASS
echo "Heat DB Sync"
su -s /bin/sh -c "heat-manage db_sync" heat
service heat-api restart
service heat-api-cfn restart
service heat-engine restart
rm -f /var/lib/heat/heat.sqlite
echo "Openstack Heat Installation Completed"
}

#Cinder
function cinder() {
echo "Openstack Cinder Installation Started"
apt-get -y install cinder-api cinder-scheduler python-cinderclient
crudini --set /etc/cinder/cinder.conf DEFAULT verbose True
crudini --set /etc/cinder/cinder.conf DEFAULT rpc_backend rabbit
crudini --set /etc/cinder/cinder.conf DEFAULT auth_strategy keystone
crudini --set /etc/cinder/cinder.conf DEFAULT my_ip $MGMT_IP
crudini --set /etc/cinder/cinder.conf DEFAULT enabled_backends lvm
crudini --set /etc/cinder/cinder.conf DEFAULT glance_host controller
crudini --set /etc/cinder/cinder.conf DEFAULT control_exchange cinder
crudini --set /etc/cinder/cinder.conf DEFAULT notification_driver messagingv2
crudini --set /etc/cinder/cinder.conf database connection mysql://cinder:$CINDER_DBPASS@controller/cinder
crudini --set /etc/cinder/cinder.conf oslo_messaging_rabbit rabbit_host controller
crudini --set /etc/cinder/cinder.conf oslo_messaging_rabbit rabbit_userid openstack
crudini --set /etc/cinder/cinder.conf oslo_messaging_rabbit rabbit_password $RABBIT_PASS
crudini --set /etc/cinder/cinder.conf keystone_authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000
crudini --set /etc/cinder/cinder.conf keystone_authtoken auth_url http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/cinder/cinder.conf keystone_authtoken auth_plugin password
crudini --set /etc/cinder/cinder.conf keystone_authtoken project_domain_id default
crudini --set /etc/cinder/cinder.conf keystone_authtoken user_domain_id default
crudini --set /etc/cinder/cinder.conf keystone_authtoken project_name service
crudini --set /etc/cinder/cinder.conf keystone_authtoken username cinder
crudini --set /etc/cinder/cinder.conf keystone_authtoken password $CINDER_PASS
crudini --set /etc/cinder/cinder.conf oslo_concurrency lock_path /var/lock/cinder
crudini --set /etc/cinder/cinder.conf lvm volume_driver cinder.volume.drivers.lvm.LVMVolumeDriver
crudini --set /etc/cinder/cinder.conf lvm volume_group cinder-volumes
crudini --set /etc/cinder/cinder.conf lvm iscsi_protocol iscsi
crudini --set /etc/cinder/cinder.conf lvm iscsi_helper tgtadm
echo "Cinder DB Sync"
su -s /bin/sh -c "cinder-manage db sync" cinder
service cinder-scheduler restart
service cinder-api restart
rm -f /var/lib/cinder/cinder.sqlite
echo " Cinder Storage Node Configuration"
apt-get -y install qemu lvm2 cinder-volume python-mysqldb
service tgt restart
service cinder-volume restart
rm -f /var/lib/cinder/cinder.sqlite
echo "Openstack Cinder Installation Completed"
}

#Ceilometer
function ceilometer() {
apt-get -y install ceilometer-api ceilometer-collector ceilometer-agent-central \
  ceilometer-agent-notification ceilometer-alarm-evaluator ceilometer-alarm-notifier ceilometer-agent-compute \
  python-ceilometerclient
crudini --set /etc/ceilometer/ceilometer.conf DEFAULT verbose True
crudini --set /etc/ceilometer/ceilometer.conf DEFAULT rpc_backend rabbit
crudini --set /etc/ceilometer/ceilometer.conf database connection mongodb://ceilometer:$CEILOMETER_DBPASS@controller:27017/ceilometer
crudini --set /etc/ceilometer/ceilometer.conf oslo_messaging_rabbit rabbit_host controller
crudini --set /etc/ceilometer/ceilometer.conf oslo_messaging_rabbit rabbit_userid openstack
crudini --set /etc/ceilometer/ceilometer.conf oslo_messaging_rabbit rabbit_password $RABBIT_PASS
crudini --set /etc/ceilometer/ceilometer.conf service_credentials os_auth_url http://ADMIN_URL_DOMAIN_NAME:5000/v2.0
crudini --set /etc/ceilometer/ceilometer.conf service_credentials os_username ceilometer
crudini --set /etc/ceilometer/ceilometer.conf service_credentials os_tenant_name service
crudini --set /etc/ceilometer/ceilometer.conf service_credentials os_password $CEILOMETER_PASS
crudini --set /etc/ceilometer/ceilometer.conf service_credentials os_endpoint_type internalURL
crudini --set /etc/ceilometer/ceilometer.conf service_credentials os_region_name $REGION
crudini --set /etc/ceilometer/ceilometer.conf publisher telemetry_secret TELEMETRY_SECRET
crudini --set /etc/ceilometer/ceilometer.conf keystone_authtoken auth_uri http://$ADMIN_URL_DOMAIN_NAME:5000/v2.0
crudini --set /etc/ceilometer/ceilometer.conf keystone_authtoken identity_uri http://$ADMIN_URL_DOMAIN_NAME:35357
crudini --set /etc/ceilometer/ceilometer.conf keystone_authtoken admin_tenant_name service
crudini --set /etc/ceilometer/ceilometer.conf keystone_authtoken admin_user ceilometer
crudini --set /etc/ceilometer/ceilometer.conf keystone_authtoken admin_password $CEILOMETER_PASS

service ceilometer-agent-central restart
service ceilometer-agent-notification restart
service ceilometer-api restart
service ceilometer-collector restart
service ceilometer-alarm-evaluator restart
service ceilometer-alarm-notifier restart
service ceilometer-agent-compute restart
service glance-registry restart
service glance-api restart
service nova-compute restart
service cinder-api restart
service cinder-scheduler restart
service cinder-volume restart
}
###function call###
ospackages
mysqlDB
mongoDB
rabbitMQ
keystone
glance
nova
neutron
horizon
heat
cinder
