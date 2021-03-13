### script to view Options menu

#source controller.sh
# Menu  show all options 
function displayMenu {

PS3='Please enter your choice: '
options=("Install Apache" "Remove Apache" "Start Apache" "Stop Apache" "Add VirtualHosts" "Remove VirtualHosts" "Authentication" "Non authentication" "Add_New_authenticationVirtualHost" "Enable virtualHost" "Disable virtualHost" "Display All Local Host" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install Apache")
		checkApache
                ApacheEXIST=${?} ##already installed
                if [ ${ApacheEXIST} == 1 ] ##already installed
                then
		echo "Already Installed"
                #read -p "Enter customer name: " Name
                #read -p "Enter invoice date: "  Date
		else 
		install_apache
                echo "Install Apache"
		fi
            ;;
         "Remove Apache")
                #read -p "Enter item name: " Name
                #read -p "Enter inv_id: "  id
                #read -p "Enter inv_quantity: " q                                                                                                                 read ->                read -p "Enter inv_unit_price: "  up
		#unstall_apache

                #echo "Remove Apache"
		##########################3
		checkApache
 		ApacheEXIST=${?} ##already installed
 		if [ ${ApacheEXIST} == 1 ] ##already installed
                then
		unstall_apache
		echo "Remove Apache"
		else 
		echo "Already Removed"
		fi
                ;;
	"Start Apache")
		checkApache
                ApacheEXIST=${?} ##already installed
                if [ ${ApacheEXIST} == 1 ] ##already installed
                then
		start_apache
		echo "Apache Started"
		else
                echo "Need To install Apache"
                fi
B		;;
	"Stop Apache")
                stop_apache
		echo "Apache Stop"
        	;;
	"Add VirtualHosts")
		checkApache
                ApacheEXIST=${?} ##already installed
                if [ ${ApacheEXIST} == 1 ] ##already installed
                then
                echo "write name"
                read  vname
		checkIfVirtualHostExistOrNot ${vname}
                flagExist=${?}
                if [ $flagExist == 0 ];then
                newlocal ${vname}
               echo "Adminstrate VirtualHosts"
               fi
		else 
		echo "Need To install Apache"
		fi
            ;;
        "Remove VirtualHosts")
	    checkApache
           ApacheEXIST=${?} ##already installed
           if [ ${ApacheEXIST} == 1 ] ##already installed
           then
	   echo "write name"
           read  vname
	   removelocalhost ${vname}
	  else 
	  echo "Need To install Apache"
	  fi
           ;;
         "Authentication")
           checkApache
           ApacheEXIST=${?} ##already installed
           if [ ${ApacheEXIST} == 1 ] ##already installed
           then
           NewUserYN="no"
           echo "website name:"
           read  vname
	   checkIfVirtualHostEnableOrNo ${vname}
	   flagExist=${?}
	   if [ $flagExist == 1 ];then
		echo "Do you want to add new user(yes/no):"
                read  NewUserYN
		#if [ ${NewUserYN} == "yes" ];then
		#echo "username:"
                #read username
		#fi
		# if [ ${NewUserYN} == "yes" ];then
	        authenticationVirtualHost ${vname} ${NewUserYN}

              #echo "Already Authentication enable"
        #   else
		#echo "Already Authentication enable"
      	    	#echo "Do you want to add new user(yes/no):"
           	# read  NewUserYN
            	#	if [ ${NewUserYN} == "yes" ];then 
	    #echo "username:"
            #read username
		#		echo ${NewUserYN}
            	#	fi
		#		echo ${NewUserYN}
	     #authenticationVirtualHost ${vname} ${username}
                #     echo "Configure Authentication"
	     fi
             else 
                echo "Need To install Apache"
             fi
            ;;
	"Non authentication")
         checkApache
         ApacheEXIST=${?} ##already installed
         if [ ${ApacheEXIST} == 1 ] ##already installed
         then
	 echo "website name (ex name.com):"
         read  vname
	 Nonauthentication ${vname}
        else
        echo "Need To install Apache"	
        fi 
        ;;
	"Add_New_authenticationVirtualHost")
         checkApache
         ApacheEXIST=${?} ##already installed
         if [ ${ApacheEXIST} == 1 ] ##already installed
         then
         echo "website name you want add user to :"
         read  name
         echo "add user name:"
         read  username
         Add_New_authenticationVirtualHost ${name} ${username}
	else 
	echo "Need to install Apache"
 	fi 	
	;;
	"Enable virtualHost")
	checkApache
         ApacheEXIST=${?} ##already installed
         if [ ${ApacheEXIST} == 1 ] ##already installed
         then
         echo "website name (ex name.com):"
         read  vname
         enableLocalHost ${vname}
         else
          echo "Need To install Apache"
         fi
	;;
	"Disable virtualHost")
	checkApache
	ApacheEXIST=${?} ##already installed
	if [ ${ApacheEXIST} == 1 ] ##already installed
	 then
         echo "website name (ex name.com):"
         read  vname
	 disableLocalHost ${vname}
         else
          echo "Need To install Apache"
         fi
        ;;
	"Display All Local Host")
	 checkApache
         ApacheEXIST=${?} ##already installed
         if [ ${ApacheEXIST} == 1 ] ##already installed
         then
          displayAllLocalHost
	else 
	echo "Need To install Apache"
	 fi
          ;;
         "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
}


#function disppplayMenu {
#	echo "Main menu"
#	echo "---------"
#	echo "1-Install Apache"
#	echo "2-Remove Apache"
#	echo "3-Start Apache"
#	echo "4-Stop Apache"
#	echo "5-Add VirtualHosts"
#	echo "6-Remove VirtualHosts"
#	echo "7-Configure Authentication"
#	echo "8-Quit"
#}
#function runMenu {
#	local CH
#	echo "Enter your choice"
#	local FLAG=1
#	while [ ${FLAG} -eq 1 ]
#	do
#	read CH
#	case ${CH} in
#         "1")
#		install_apache
#                echo "Install Apache"
#	    ;;
#	  "2")
#		unstall_apache
#                echo "Remove Apache"
#            ;;
#	  "3")
#		start_apache
#                echo "Apache Started"
#            ;;
#	  "4")
#		stop_apache
#                echo "Apache Stop"
#	   ;;
#	  "5")
##		echo "enter website name :"
#                read NAME
#                addNewLocalHost ${NAME}
#	   }
