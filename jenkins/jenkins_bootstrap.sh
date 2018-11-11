#!/usr/bin/env bash
 
echo -e "-- ------------------ --\n"
echo -e "-- BEGIN Installation --\n"
echo -e "-- ------------------ --\n"
 
# VARIABLES 
echo -e "-- Setting global variables\n"
APACHE_CONFIG=/etc/apache2/apache2.conf
VIRTUAL_HOST=localhost
DOCUMENT_ROOT=/var/www/html
 
apt-get update -y -qq
apt-get install -y apache2
 
echo -e "-- Adding ServerName to Apache config\n"
grep -q "ServerName ${VIRTUAL_HOST}" "${APACHE_CONFIG}" || echo "ServerName ${VIRTUAL_HOST}" >> "${APACHE_CONFIG}"
 
echo -e "-- Allowing Apache override to all\n"
sed -i "s/AllowOverride None/AllowOverride All/g" ${APACHE_CONFIG}
 
echo -e "-- Updating vhost file\n"
cat > /etc/apache2/sites-enabled/000-default.conf <<EOF
<VirtualHost *:80>
    ServerName ${VIRTUAL_HOST}
    DocumentRoot ${DOCUMENT_ROOT}
 
    <Directory ${DOCUMENT_ROOT}>
        Options Indexes FollowSymlinks
        AllowOverride All
        Order allow,deny
        Allow from all
        Require all granted
    </Directory>
 
    ErrorLog ${APACHE_LOG_DIR}/${VIRTUAL_HOST}-error.log
    CustomLog ${APACHE_LOG_DIR}/${VIRTUAL_HOST}-access.log combined
</VirtualHost>
EOF

service apache2 restart
 
# INSTALLING JAVA
# add-apt-repository ppa:webupd8team/java
apt-add-repository ppa:ansible/ansible
apt-get -y -q update
apt-get -y -q upgrade
apt-get -y -q install software-properties-common ansible

git clone https://github.com/abdelhegazi/eq-exp.git
cd eq-exp/jenkins
ansible-playbook -i inventory ansible/jenkins.yaml -vvvv

# echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
# apt-get -y -q install oracle-java8-installer
# apt-get -y -q install linux-tools-generic linux-cloud-tools-generic
# update-java-alternatives -s java-8-oracle
 
# # INSTALLING JENKINS  
# wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add - > /dev/null 2>&1
# sh -c "echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list"
 
# apt-get update -y -qq
# apt-get install jenkins -y -qq

echo -e "-- ---------------- --"
echo -e "-- END Installation --"
echo -e "-- ---------------- --"
