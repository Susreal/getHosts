#!/bin/sh 
echo "-------------------------------------------------------"
echo "hosts updater for google and facebook--by Susreal, SJTU" 
echo `date`
echo "-------------------------------------------------------"

#get the latest hosts using scrapy,results are in "hosts_new"
cd getHosts
scrapy crawl getGoogleHosts

#merge two hosts file, which localhosts infomation is in the "hosts_org"
cat hosts_org hosts_new > hosts 
#add "127.0.0.1 $hostname" to the first line
#echo "127.0.0.1 `hostname`"
sed -i "1i127.0.0.1\t`hostname`" hosts

#details
sed -i "1i#######################################################################" hosts
sed -i "1i#hosts updated : `date` --by Susreal, SJTU" hosts
sed -i "1i#######################################################################" hosts

cp /etc/hosts hosts_backup
cp hosts /etc/hosts
sudo /etc/init.d/networking restart
