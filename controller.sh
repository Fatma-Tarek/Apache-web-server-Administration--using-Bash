### Script to control apache services

### Function to start Apche
#Exit codes:
#	0:success
#	1:already started
#       2:can't stop Apache 
function start_apache {
		sudo service apache2 restart
		 echo "Process is running."
}

#  Function to Stop Apache
function stop_apache {
sudo service apache2 stop

}

function install_apache {

sudo apt-get update
sudo apt-get install apache2
echo "Apache Installed"

}
function unstall_apache {
sudo apt-get --purge remove apache2
sudo apt-get remove apache2-common
}

function displayAllLocalHost {
      apache2ctl -S | grep 'port'| cut -d' ' -f13 > allLocalHost
      cut -d' ' -f13 allLocalHost
}

function newlocal {
   # echo ${1}
#     checkNameOfVH ${1}
  #   if [ ! -d "/var/www/websites/${1}" ]
     #if grep -Fxq "${1}" allLocalHost;
 #    then
      newlocalhost=${1}
      echo ${newlocalhost}
      mkdir /var/www/websites/${newlocalhost}
      touch /var/www/websites/${newlocalhost}/index.html
      echo "<html><title>${newlocalhost} page</title><body><center><h1>${newlocalhost} website</h1></center></body>">/var/www/websites/${newlocalhost}/index.html
      touch /etc/apache2/sites-available/${newlocalhost}.conf
      echo  "<VirtualHost *:80>">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo -E "DocumentRoot /var/www/websites/${newlocalhost}">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo "ServerName ${newlocalhost}">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo -E "</VirtualHost>">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo -E "<Directory /var/www/websites/${newlocalhost}>">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo  "Options ALL">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo "AllowOverride All">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo "Require all granted">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo -E "</Directory>">>/etc/apache2/sites-available/${newlocalhost}.conf
      echo "127.0.0.1     ${newlocalhost}">> /etc/hosts
      echo "127.0.0.1  ${newlocalhost}">>/mnt/c/Windows/system32/drivers/etc/hosts
     # enableLocalHost ${newlocalhost}

     a2ensite ${1}
     service apache2 restart
   #  else
#	echo "Virtual Host is already exit"
    # fi
 }
function enableLocalHost {
     a2ensite ${1}
     service apache2 restart
}

function removelocalhost {
   NUM_LINE=1
   while read -r line;do
   if [ "$line" == "127.0.0.1 ${1}" ]; then
   REQ_LINE=${NUM_LINE}
   fi
   NUM_LINE=$(expr ${NUM_LINE} + 1)
   done <"/mnt/c/Windows/system32/drivers/etc/hosts"
   sed -i "${REQ_LINE}d" /mnt/c/Windows/system32/drivers/etc/hosts
   LocalHostName=${1}
   rm /etc/apache2/sites-available/${LocalHostName}.conf
   rm -r /var/www/websites/${LocalHostName} #-RF
   service apache2 restart
}

function checkIfVHostIsExist {
   NUM_LINE=1
   while read -r line;do
   if [ "$line" == "${1}" ]; then
    echo "Virtual Host is already exist please change name ex(xxx.com)"
    $flag =0;
    echo "flag" 
   fi
   done <"allLocalHost"
}

function authenticationVirtualHost {
nameOfWebsite=${1} 
if [ ${2} == "yes" ]; then
echo " enter username"
read name
userName=${name}
sudo touch /var/www/websites/${nameOfWebsite}/.htpasswd
sudo htpasswd /var/www/websites/${nameOfWebsite}/.htpasswd ${userName}
fi
nameOfWebsite=${1}
#userName=${2}
sudo touch /var/www/websites/${nameOfWebsite}/.htaccess
echo "AuthType Basic
AuthName 'Restricted Content'
AuthUserFile /var/www/websites/${nameOfWebsite}/.htpasswd
Require valid-user">>/var/www/websites/${nameOfWebsite}/.htaccess

echo "
<VirtualHost *:80>
DocumentRoot /var/www/websites/${nameOfWebsite}
ServerName ${nameOfWebsite}
</VirtualHost>
<Directory /var/www/websites/${nameOfWebsite}>
AllowOverride All
</Directory>
">/etc/apache2/sites-available/${nameOfWebsite}.conf
sudo service apache2 restart
}

function Add_New_authenticationVirtualHost {
nameOfWebsite=${1}
userName=${2}
sudo touch /var/www/websites/${nameOfWebsite}/.htpasswd
sudo htpasswd /var/www/websites/${nameOfWebsite}/.htpasswd ${userName}
service apache2 restart
}


function Nonauthentication1 {
nameOfWebsite=${1}
#echo "
echo "<VirtualHost *:80>">/etc/apache2/sites-available/${nameOfWebsite}.conf
echo -E "DocumentRoot /var/www/websites/${nameOfWebsite}
ServerName ${nameOfWebsite}
</VirtualHost>
<Directory /var/www/websites/${nameOfWebsite}>
AllowOverride none
</Directory>
">>/etc/apache2/sites-available/${nameOfWebsite}.conf
sudo service apache2 restart
}

function Nonauthentication {
nameOfWebsite=${1}
#echo "
echo "<VirtualHost *:80>">/etc/apache2/sites-available/${nameOfWebsite}.conf
echo -E "DocumentRoot /var/www/websites/${nameOfWebsite}
ServerName ${nameOfWebsite}
</VirtualHost>
<Directory /var/www/websites/${nameOfWebsite}>
AllowOverride all
Require all granted
</Directory>
">>/etc/apache2/sites-available/${nameOfWebsite}.conf
sudo service apache2 restart
}













function checkNameOfVH {
if grep -Fxq "${1}" allLocalHost; then 
echo "Can't add these name"
fi
}
