#!/bin/bash
PATH=/bin:/usr/bin:

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning puppet-master${NONE}${NONE} ${RED}**********${NONE}"

echo jenkins | sudo -S docker exec puppet-master yum update -y 
   
echo jenkins | sudo -S docker exec puppet-master service sshd start
   
echo jenkins | sudo -S docker exec puppet-master service puppetmaster start
   
echo jenkins | sudo -S docker exec puppet-master puppet cert list -a

echo jenkins | sudo -S docker exec puppet-master puppet cert clean jenkins.infostretch.com nginx-load-balancer.infostretch.com app-server-1.infostretch.com app-server-2.infostretch.com
   
echo jenkins | sudo -S docker exec puppet-master ls -lart /var/lib/puppet/ssl/ca/signed/

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning nginx-load-balancer${NONE}${NONE} ${RED}**********${NONE}"

echo jenkins | sudo -S docker exec nginx-load-balancer yum update -y 
   
echo jenkins | sudo -S docker exec nginx-load-balancer service sshd start
   
echo jenkins | sudo -S docker exec nginx-load-balancer service puppet start
   
echo jenkins | sudo -S docker exec nginx-load-balancer rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec nginx-load-balancer puppet agent -t
   
echo jenkins | sudo -S docker exec puppet-master puppet cert list -a
   
echo jenkins | sudo -S docker exec puppet-master puppet cert sign nginx-load-balancer.infostretch.com

sleep 5
   
echo jenkins | sudo -S docker exec nginx-load-balancer puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec nginx-load-balancer rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec puppet-master puppet cert clean nginx-load-balancer.infostretch.com

sleeo 5

echo jenkins | sudo -S docker exec nginx-load-balancer puppet agent -t
   
echo jenkins | sudo -S docker exec puppet-master puppet cert list -a
   
echo jenkins | sudo -S docker exec puppet-master puppet cert sign nginx-load-balancer.infostretch.com

sleep 5
   
echo jenkins | sudo -S docker exec nginx-load-balancer puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec nginx-load-balancer puppet agent -t

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning app-server-1${NONE}${NONE} ${RED}**********${NONE}"

echo jenkins | sudo -S docker exec app-server-1 yum update -y 

echo jenkins | sudo -S docker exec app-server-1 service sshd start
   
echo jenkins | sudo -S docker exec app-server-1 service puppet start
   
echo jenkins | sudo -S docker exec app-server-1 rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec app-server-1 puppet agent -t
   
echo jenkins | sudo -S docker exec puppet-master puppet cert list -a
   
echo jenkins | sudo -S docker exec puppet-master puppet cert sign app-server-1.infostretch.com

sleep 5
   
echo jenkins | sudo -S docker exec app-server-1 puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec app-server-1 rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec puppet-master puppet cert clean app-server-1.infostretch.com

sleep 5

echo jenkins | sudo -S docker exec app-server-1 puppet agent -t

echo jenkins | sudo -S docker exec puppet-master puppet cert list -a

echo jenkins | sudo -S docker exec puppet-master puppet cert sign app-server-1.infostretch.com

sleep 5

echo jenkins | sudo -S docker exec app-server-1 puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec app-server-1 puppet agent -t

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning app-server-2${NONE}${NONE} ${RED}**********${NONE}"

echo jenkins | sudo -S docker exec app-server-2 yum update -y 

echo jenkins | sudo -S docker exec app-server-2 service sshd start
   
echo jenkins | sudo -S docker exec app-server-2 service puppet start

echo jenkins | sudo -S docker exec app-server-2 rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec app-server-2 puppet agent -t
   
echo jenkins | sudo -S docker exec puppet-master puppet cert list -a
   
echo jenkins | sudo -S docker exec puppet-master puppet cert sign app-server-2.infostretch.com

sleep 5

echo jenkins | sudo -S docker exec app-server-2 puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec app-server-2 rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec puppet-master puppet cert clean app-server-2.infostretch.com 

sleep 5

echo jenkins | sudo -S docker exec app-server-2 puppet agent -t

echo jenkins | sudo -S docker exec puppet-master puppet cert list -a

echo jenkins | sudo -S docker exec puppet-master puppet cert sign app-server-2.infostretch.com

sleep 5

echo jenkins | sudo -S docker exec app-server-2 puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec app-server-2 puppet agent -t

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning jenkins server${NONE}${NONE} ${RED}**********${NONE}"

echo jenkins | sudo -S docker exec jenkins yum update -y 

echo jenkins | sudo -S docker exec jenkins service sshd start

echo jenkins | sudo -S docker exec jenkins service jenkins start
   
echo jenkins | sudo -S docker exec jenkins service puppet start

echo jenkins | sudo -S docker exec jenkins rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec jenkins puppet agent -t
   
echo jenkins | sudo -S docker exec puppet-master puppet cert list -a
   
echo jenkins | sudo -S docker exec puppet-master puppet cert sign jenkins.infostretch.com

sleep 5

echo jenkins | sudo -S docker exec jenkins puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec jenkins rm -rf /var/lib/puppet/ssl

echo jenkins | sudo -S docker exec puppet-master puppet cert clean jenkins.infostretch.com 

sleep 5

echo jenkins | sudo -S docker exec jenkins puppet agent -t

echo jenkins | sudo -S docker exec puppet-master puppet cert list -a

echo jenkins | sudo -S docker exec puppet-master puppet cert sign jenkins.infostretch.com

echo jenkins | sudo -S docker exec puppet-master puppet cert list -a

sleep 5

echo jenkins | sudo -S docker exec jenkins puppet agent -t

sleep 5

echo jenkins | sudo -S docker exec jenkins puppet agent -t

tput sgr0
