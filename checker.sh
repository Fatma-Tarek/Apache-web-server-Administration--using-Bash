function checkIfVirtualHostExistOrNot {
	VIRTUALHOSTNAME=${1}
        flag=1
        if grep -Fxq "${VIRTUALHOSTNAME}" allLocalHost; then
        echo "Can't add these name"
        flag=1
	else
        flag=0
	#newlocal ${1}
 	fi
	return $[flag]
}

#function checkFile_htaccess_Exist {
#	VIRTUALHOSTNAME=${1}
#        flag=1
#        if grep if [ ! -f "/var/www/websites/${1}/.htaccess" ]; then
#        echo "Already Authentication done"
#        flag=1
#        else
#        flag=0
#        #newlocal ${1}
#        fi
#        return $[flag]
#}

function checkIfVirtualHostEnableOrNo1 {
	authVirtualHost=${1}
 	Flag_authorized=1
 	while read -r line;do
 	if [ "$line" == " AllowOverride All" ]; then
        echo ${line}
        echo "authorized"
	 Flag_authorized=1
         break;
 	else
 	echo "not authorized"
 	Flag_authorized=0
 	fi
 	done <"/etc/apache2/sites-available/${authVirtualHost}.conf"
	return $[Flag_authorized]
}

function checkIfVirtualHostEnableOrNo
{
authVirtualHost=${1} 
# read -p "Enter name of virtualhost you want to make auth for it : " authVirtualHost
 Flag_authorized=1
 while read -r line;do
 if [ "$line" == "Require all granted" ] || [ "$line" == "AllowOverride none" ]; then ###m7taga authantication
 echo "not authorized" 
 Flag_authorized=1 ##m7ataga call ll 
 break
 #else 
 #echo "authorized" ####m3moloo authorized
 #Flag_authorized=0
 fi
 done <"/etc/apache2/sites-available/${authVirtualHost}.conf"

 return $[Flag_authorized]

}
















