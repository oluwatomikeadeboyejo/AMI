# Update System Packages
sudo yum update -y

# Install EPEL for additional packages
sudo amazon-linux-extras install epel -y

# Install Python 2 
sudo yum install python2 -y
python2 --version

# Install Ansible
sudo yum install ansible -y
ansible --version

# Install Git 
sudo yum install git -y
