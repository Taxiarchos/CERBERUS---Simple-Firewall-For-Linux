#!/bin/bash

sudo echo -e "Checking connection status...\n"
sudo netstat -tunap
echo " "
echo "Checking for listening ports..."
sudo netstat -tunlp | grep LISTEN
echo " "
echo " "


echo "Do you want to activate Cerberus firewall?"
echo "type (y/N)"


while [[ $input != "y" && $input != "N" ]]
   do
     read input
     if [[ $input = "y" ]]; then
            echo " "
             for (( i = 2; i > 1; i += 1 ));
              do 
		for(( pnum = 0 ; pnum < 65536 ; pnum += 1 ));
		  do
		   sudo netstat -tunap | grep ":$pnum" | grep "ESTABLISHED"
		   sudo netstat -tunap | grep ":$pnum" | grep "RELATED" 
	
		   sudo iptables-legacy -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -p tcp --dport $pnum -j ACCEPT
		   sudo iptables-legacy -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -p udp --dport $pnum -j ACCEPT 
		   sudo iptables-legacy -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -p tcp --sport $pnum -j ACCEPT
		   sudo iptables-legacy -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -p udp --sport $pnum -j ACCEPT
		   
		   sudo netstat -tunap | grep ":$pnum" | grep "NEW"
		   
		   sudo iptables-legacy -A INPUT -m conntrack --ctstate NEW -p tcp --dport $pnum -j DROP 
		   sudo iptables-legacy -A INPUT -m conntrack --ctstate NEW -p udp --dport $pnum -j DROP
		   sudo iptables-legacy -A OUTPUT -m conntrack --ctstate NEW -p tcp --sport $pnum -j ACCEPT
		   sudo iptables-legacy -A OUTPUT -m conntrack --ctstate NEW -p udp --sport $pnum -j ACCEPT
		   
		   sudo netstat -tunap | grep ":$pnum" | grep "INVALID"
		  
		   sudo iptables-legacy -A INPUT -m conntrack --ctstate INVALID -p tcp --dport $pnum -j DROP 
		   sudo iptables-legacy -A INPUT -m conntrack --ctstate INVALID -p udp --dport $pnum -j DROP 
		   sudo iptables-legacy -A OUTPUT -m conntrack --ctstate INVALID -p tcp --sport $pnum -j DROP
		   sudo iptables-legacy -A OUTPUT -m conntrack --ctstate INVALID -p udp --sport $pnum -j DROP  
		  done
		       echo "Cerberus Firewall protected your connections!"
		       echo " "
		       echo "Cerberus will be run again in 5 minutes..."
		       sleep 300
               done > /dev/tty
     elif [[ $input = "N" ]]; then
         echo "Exiting the program..."
         break
     else 
         echo "invalid input"
         echo "please type y or N..."
     fi
    done