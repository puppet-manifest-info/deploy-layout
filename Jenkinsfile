node('master') {
    wrap([$class: 'AnsiColorBuildWrapper', colorMapName: 'xterm']) {

        timestamps {
 //         step([$class: 'WsCleanup'])
            sh "echo jenkins | sudo -S docker ps -a"
//            sh "ls -lart && rm -rf * && ls -lart"
            stage ('Git Checkout') { scm() }
            stage ('Setup Docker Environment') { CleanEnv() }
//            stage ('Prepare the Environment') { prepareEnv() }
            stage ('Build puppet-master') { buildPuppetMaster() }
            stage ('Build nginx-load-balancer') { buildNginxLoadBalancer() }
            stage ('Build App-server-1') { buildAppServer1() }
            stage ('Build App-server-2') { buildAppServer2() }
            stage ('Build Jenkins server') { buildJenkins() }
//            stage ('Trigger testtest1') { triggerbuild() }
            stage ('prepare the servers') { prepareServers() }
            stage ('Deploy Catalog on nginx-load-balancer') { deployCatalogNginxLoadBalancer() }
            stage ('Deploy Catalog on app-server-1') { deployCatalogAppServer1() }
            stage ('Deploy Catalog on app-server-2') { deployCatalogAppServer2() }
            step([$class: 'WsCleanup'])
        }
    }    
}

def scm() {
    
    checkout scm
}

def CleanEnv() {

    sh 'echo jenkins | sudo -S docker pull peddadabrp/puppet-demo:master.1.0.9'
    sh 'echo jenkins | sudo -S docker pull peddadabrp/puppet-demo:agent.1.0.4'
    sh 'echo jenkins | sudo -S docker stop puppet-master nginx-load-balancer app-server-1 app-server-2'
    sh 'echo jenkins | sudo -S docker rm puppet-master nginx-load-balancer app-server-1 app-server-2'

}

def prepareEnv() {

    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.22 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name puppet-master -h puppet-master.infostretch.com -p 8081:8080 peddadabrp/puppet-demo:master.1.0.9 bash'
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.23 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name nginx-load-balancer -h nginx-load-balancer.infostretch.com -p 80:80 peddadabrp/puppet-demo:agent.1.0.4 bash'
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.24 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name app-server-1 -h app-server-1.infostretch.com -p 4000:3000 peddadabrp/puppet-demo:agent.1.0.4 bash'
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.25 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name app-server-2 -h app-server-2.infostretch.com -p 5000:3000 peddadabrp/puppet-demo:agent.1.0.4 bash'
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.26 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --name jenkins -h jenkins.infostretch.com -p 8082:8080 peddadabrp/puppet-demo:jenkins.1.0.0 bash'

}

def buildPuppetMaster() {
    
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.22 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name puppet-master -h puppet-master.infostretch.com -p 8081:8080 peddadabrp/puppet-demo:master.1.0.9 bash'
}

def buildNginxLoadBalancer() {
    
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.23 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name nginx-load-balancer -h nginx-load-balancer.infostretch.com -p 80:80 peddadabrp/puppet-demo:agent.1.0.4 bash'
}

def buildAppServer1() {
    
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.24 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name app-server-1 -h app-server-1.infostretch.com -p 4000:3000 peddadabrp/puppet-demo:agent.1.0.4 bash'
}

def buildAppServer2() {
    
   sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.25 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "jenkins  jenkins.infostretch.com":172.18.0.26 --name app-server-2 -h app-server-2.infostretch.com -p 5000:3000 peddadabrp/puppet-demo:agent.1.0.4 bash' 
}

def buildJenkins() {
 
    sh 'echo jenkins | sudo -S docker run --net puppetdemo --ip 172.18.0.26 -dit -v /var/lib/jenkins/dockerResources:/var/lib/jenkins/dockerResources --add-host "nginx-load-balancer  nginx-load-balancer.infostretch.com":172.18.0.23 --add-host "app-server-1  app-server-1.infostretch.com":172.18.0.24 --add-host "app-server-2  app-server-2.infostretch.com":172.18.0.25 --add-host "puppet-master  puppet-master.infostretch.com":172.18.0.22 --name jenkins -h jenkins.infostretch.com -p 8082:8080 peddadabrp/puppet-demo:jenkins.1.0.0 bash'
    
}    

def prepareServers() {

//    sh 'sh /var/lib/jenkins/shell-scripts/puppet-agent.sh'
    sh 'sh $WORKSPACE/provision-script.sh'
}

def triggerbuild() {
    build job: 'testtest1', propagate: false
    sh 'sleep 30'
}

def deployCatalogNginxLoadBalancer() {
    
    sh 'echo jenkins | sudo -S docker exec nginx-load-balancer puppet agent -t'
}

def deployCatalogAppServer1() {
    
    sh 'echo jenkins | sudo -S docker exec app-server-1 puppet agent -t'
    sh 'echo jenkins | sudo -S docker exec app-server-1 nohup sh /var/lib/jenkins/app/deploy.sh &> output.txt &'
}

def deployCatalogAppServer2() {
    
    sh 'echo jenkins | sudo -S docker exec app-server-2 puppet agent -t'
    sh 'echo jenkins | sudo -S docker exec app-server-2 nohup sh /var/lib/jenkins/app/deploy.sh &> output.txt &'
    sh 'sleep 10'
}

