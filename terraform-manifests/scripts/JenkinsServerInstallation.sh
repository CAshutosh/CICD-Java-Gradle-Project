#! /bin/bash

# Install Java
amazon-linux-extras install java-openjdk11 -y

# Download and Install Jenkins
yum update -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y

# Start Jenkins
systemctl start jenkins

# Enable jenkins (It will start automatically at the next system restart)
systemctl enable jenkins

# Install Git SCM
yum install git -y

# Make sure Jenkins comes up when reboot
chkconfig jenkins on



# Install docker
# Update the installed packages and package cache 
yum update -y
# Install the most recent Docker Engine package for Amazon Linux 2
amazon-linux-extras install docker -y
# Start the Docker service.
service docker start
# Add the ansibleadmin to the docker group so you can execute Docker commands without using sudo.
usermod -a -G docker ansibleadmin
# Configure Docker to start on boot
sudo systemctl enable docker
sudo yum install python2-pip
sudo pip2 install docker-py
sudo pip install docker
sudo pip install docker-py



# Install Helm
# Install required packages
sudo yum install -y curl
# Download the Helm installation script
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
# Make the script executable
chmod +x get_helm.sh
# Install Helm
./get_helm.sh


# Install datree helm plugin
# Download the Datree Helm plugin installation script
curl https://get.datree.io/helm-plugin-install.sh > helm-plugin-install.sh
# Make the script executable
chmod +x helm-plugin-install.sh
# Install the Datree Helm plugin
./helm-plugin-install.sh