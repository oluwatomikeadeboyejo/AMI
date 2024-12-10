#/bin/bash

yum install -y awslogs

sed -i 's/us-east-1/us-east-1/' /etc/awslogs/awscli.conf
systemctl enable awslogsd.service
systemctl start awslogsd.service
