#!/bin/bash

echo "########################################"
echo "Installation Script Docker Centos 7"
echo "########################################"

user_current=$(whoami)

if [ $user_current == 'root' ]; then

	echo 'Name user not root for permission to docker (Obligatory):'
	read user

	if getent passwd $user > /dev/null 2>&1; then
		yum install -y yum-utils device-mapper-persistent-data lvm2
		yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
		yum update -y
		yum install -y docker-ce
		systemctl start docker
		systemctl enable docker
		echo '{ "exec-opts": ["native.cgroupdriver=systemd"], "log-driver": "json-file", "log-opts": { "max-size": "100m" }, "storage-driver": "overlay2", "storage-opts": [ "overlay2.override_kernel_check=true" ] }' > /etc/docker/daemon.json
		usermod -aG docker $user
		sudo -u $user -H bash -c "source ~/.bashrc; docker info"
		echo " "
		echo " "
		echo "########################################"
		echo "Installation Complete .................."
		echo "Execute: docker info or docker ps"
		echo "########################################"
		echo " "
		echo " "
		su $user
	else
    	echo "The user does not exist";exit 1;
	fi

else
	echo "Script only can to use with root user !!!!!!!!!";exit 1;
fi



