
#!/bin/bash

#based on: https://msftstack.wordpress.com/2016/05/12/extension-sequencing-in-azure-vm-scale-sets/
#wait for the Linux Diagnostic Extension to get up and running before we kick off
while ( ! (find /var/log/azure/Microsoft.OSTCExtensions.LinuxDiagnostic/*/extension.log | xargs grep "Start mdsd"));
do
  sleep 5 
done 

# based on: https://www.digitalocean.com/community/tutorials/how-to-install-java-on-centos-and-fedora 

#Install Oracle JRE
cd ~
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.rpm"

yum -y localinstall jre-8u60-linux-x64.rpm

rm jre-8u60-linux-x64.rpm

#based on: https://dpastov.blogspot.co.uk/2015/10/setup-play-framework-and-typesafe-centos.html
#Install Activator
wget "https://downloads.typesafe.com/typesafe-activator/1.3.12/typesafe-activator-1.3.12.zip"

unzip typesafe-activator-1.3.12.zip
mv activator-dist-1.3.12 /opt

rm typesafe-activator-1.3.12.zip

ln -s /opt/activator-dist-1.3.12/bin/activator /usr/local/sbin/activator

echo 'pathmunge /usr/local/sbin/activator' > /etc/profile.d/activatorpath.sh
chmod +x /etc/profile.d/activatorpath.sh

#reload profile
. /etc/profile

#make default directory to host projects
cd /var
mkdir www

#udpate system packages
yum update -y --exclude=WALinuxAgent



