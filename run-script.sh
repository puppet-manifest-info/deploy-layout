#! bin/bash

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning puppet-master${NONE}${NONE} ${RED}**********${NONE}"

docker exec puppet-master yum update -y 
   
docker exec puppet-master service sshd start
   
docker exec puppet-master service puppetmaster start
   
docker exec puppet-master puppet cert list -a

docker exec puppet-master puppet cert clean nginx-load-balancer.infostretch.com app-server-1.infostretch.com app-server-2.infostretch.com
   
docker exec puppet-master ls -lart /var/lib/puppet/ssl/ca/signed/

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning nginx-load-balancer${NONE}${NONE} ${RED}**********${NONE}"

docker exec nginx-load-balancer yum update -y 
   
docker exec nginx-load-balancer service sshd start
   
docker exec nginx-load-balancer service puppet start
   
docker exec nginx-load-balancer rm -rf /var/lib/puppet/ssl

docker exec nginx-load-balancer puppet agent -t
   
docker exec puppet-master puppet cert list -a
   
docker exec puppet-master puppet cert sign nginx-load-balancer.infostretch.com

sleep 5
   
docker exec nginx-load-balancer puppet agent -t

sleep 5

docker exec nginx-load-balancer rm -rf /var/lib/puppet/ssl

docker exec puppet-master puppet cert clean nginx-load-balancer.infostretch.com

sleeo 5

docker exec nginx-load-balancer puppet agent -t
   
docker exec puppet-master puppet cert list -a
   
docker exec puppet-master puppet cert sign nginx-load-balancer.infostretch.com

sleep 5
   
docker exec nginx-load-balancer puppet agent -t

sleep 5

docker exec nginx-load-balancer puppet agent -t

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning app-server-1${NONE}${NONE} ${RED}**********${NONE}"

docker exec app-server-1 yum update -y 

docker exec app-server-1 service sshd start
   
docker exec app-server-1 service puppet start
   
docker exec app-server-1 rm -rf /var/lib/puppet/ssl

docker exec app-server-1 puppet agent -t
   
docker exec puppet-master puppet cert list -a
   
docker exec puppet-master puppet cert sign app-server-1.infostretch.com

sleep 5
   
docker exec app-server-1 puppet agent -t

sleep 5

docker exec app-server-1 rm -rf /var/lib/puppet/ssl

docker exec puppet-master puppet cert clean app-server-1.infostretch.com

sleep 5

docker exec app-server-1 puppet agent -t

docker exec puppet-master puppet cert list -a

docker exec puppet-master puppet cert sign app-server-1.infostretch.com

sleep 5

docker exec app-server-1 puppet agent -t

sleep 5

docker exec app-server-1 puppet agent -t

echo -e "${RED}**********${NONE} ${UNDERLINE}${GREEN}Provisioning app-server-2${NONE}${NONE} ${RED}**********${NONE}"

docker exec app-server-2 yum update -y 

docker exec app-server-2 service sshd start
   
docker exec app-server-2 service puppet start

docker exec app-server-2 rm -rf /var/lib/puppet/ssl

docker exec app-server-2 puppet agent -t
   
docker exec puppet-master puppet cert list -a
   
docker exec puppet-master puppet cert sign app-server-2.infostretch.com

sleep 5

docker exec app-server-2 puppet agent -t

sleep 5

docker exec app-server-2 rm -rf /var/lib/puppet/ssl

docker exec puppet-master puppet cert clean app-server-2.infostretch.com 

sleep 5

docker exec app-server-2 puppet agent -t

docker exec puppet-master puppet cert list -a

docker exec puppet-master puppet cert sign app-server-2.infostretch.com

sleep 5

docker exec app-server-2 puppet agent -t

sleep 5

docker exec app-server-2 puppet agent -t
