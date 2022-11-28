# Install Db2 Database Client on Bastion(RHEL 9)

## Download the Data Server Client
Please follow the link [https://www.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%2FInformation%20Management&product=ibm/Information+Management/IBM+Data+Server+Client+Packages&release=11.5.8.0&platform=Linux+64-bit,x86_64&function=fixId&fixids=*rtcl*FP000&includeSupersedes=0&source=fc](https://www.ibm.com/support/fixcentral/swg/selectFixes?parent=ibm%2FInformation%20Management&product=ibm/Information+Management/IBM+Data+Server+Client+Packages&release=11.5.8.0&platform=Linux+64-bit,x86_64&function=fixId&fixids=*rtcl*FP000&includeSupersedes=0&source=fc) and download the Data Server Client, the version is 11.5.8.0.


## Install DS Client on RHEL

1. Upload the `v11.5.8_linuxx64_rtcl.tar.gz` to the RHEL 9 Batsion host `/tmp` folder.
2. Untar the .gz file
```
cd /tmp
tar -xvf v11.5.8_linuxx64_rtcl.tar.gz
```
3. Install dependent libs
```
sudo yum install libpam.so* libpam.so.0 libaio binutils -y
```
4. Create a linux user - db2inst1
```
sudo useradd db2inst1 
```
5. Swith user
```
sudo su - db2inst1
```
6. Run db2 install script
```
/tmp/rtcl/db2_install 
```
Note: please accept the terms by typing `yes` in the prompt.
7. Source profile
```
. $HOME/sqllib/db2profile
```



## Set up DB2 catalog

### Catalog node
```
db2 catalog tcpip node DGNode remote <db2_server> server <db2_port>
```
### Catalog database
```
db2 catalog database BLUDB as BLUDB at node DGNode
```

The DB2 client is good to use.


