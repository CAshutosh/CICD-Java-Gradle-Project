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
usermod -a -G docker ec2-user
# Configure Docker to start on boot
sudo systemctl enable docker
sudo yum install python2-pip
sudo pip2 install docker-py
sudo pip install docker
sudo pip install docker-py



# install ansible
yum-config-manager --enable epel
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install epel-release-latest-7.noarch.rpm
yum update -y
yum install python python-devel python-pip openssl ansible -y

sudo su -

# add the user ansible admin
sudo useradd ansibleadmin

# set password : the below command will avoid re entering the password
sudo echo "ansibleansible" | passwd --stdin ansibleadmin

# modify the sudoers file at /etc/sudoers and add entry
echo 'ansibleadmin     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers
echo 'ec2-user     ALL=(ALL)      NOPASSWD: ALL' | sudo tee -a /etc/sudoers

# the below sed command will find and replace words with spaces "PasswordAuthentication no" to "PasswordAuthentication yes"
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart
