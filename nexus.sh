#apt-get update
#apt install openjdk-17-jre-headless
#apt install net-tools

cd /opt
wget https://download.sonatype.com/nexus/3/nexus-3.84.1-01-linux-x86_64.tar.gz
tar -zxvf nexus-3.84.1-01-linux-x86_64.tar.gz

#adduser nexus
#chown -R nexus:nexus nexus-3.84.1-01
#chown -R nexus:nexus sonatype-work
#
#vim nexus-3.84.1-01/bin/nexus.rc
#run_as_user="nexus"
#
#su - nexus
#/opt/nexus-3.84.1-01/bin/nexus start
#
#ps aux | grep nexus
#netstat -lnpt