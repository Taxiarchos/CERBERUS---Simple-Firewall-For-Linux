#!/bin/bash

if [[ -e /etc/alternatives/iptables-restore && -e /etc/alternatives/iptables-save && -e /etc/alternatives/iptables ]]; then
    sudo rm /etc/alternatives/iptables-restore
    sudo rm /etc/alternatives/iptables-save
    sudo rm /etc/alternatives/iptables
    
    echo " "     
    echo "!! PRESS 1 TO SELECT iptables-legacy !!"
    echo " "
    sudo ln -s /usr/sbin/iptables-legacy-restore /etc/alternatives/iptables-restore >> chroot_scripts/iptables-legacy.sh
    sudo ln -s /usr/sbin/iptables-legacy-save /etc/alternatives/iptables-save >> chroot_scripts/iptables-legacy.sh
    sudo ln -s /usr/sbin/iptables-legacy /etc/alternatives/iptables >> chroot_scripts/iptables-legacy.sh
 
    sudo update-alternatives --config iptables
    sudo update-alternatives --config ip6tables
  
else 
    echo "Configuration files are ready..."
    exit > /dev/tty
fi

