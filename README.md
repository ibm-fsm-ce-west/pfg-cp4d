# Cloud Pak for Data 4.5 Install on ROSA

## Pre-requisites
### Workstation
- [x] Docker or Podman
- [x] Cpd-cli 
- [x] OCP CLI
- [x] Access to `icr.io`


### ROSA Requirements
- [x] 3 Master Nodes with 8vCPU and 32GB RAM
- [x] 5 Worker Nodes with 16vCPU and 64GB RAM
- [x] OCP 4.8+

---

## Setup ROSA

### AWS Configure Identity and Access Management (IAM) 
This configuration is set on AWS web console. We will need to get **Access Key ID** and **Secret Access Key** in this step.

1. Click on search bar in the upper left hand corner and search for `IAM`.
2. On the left hand side, click `Users` and then click your username.
3. Click the `Security credentials` secion and click `Create access Key`.
4. Copy and save the **Access Key ID** and **Secret Access Key**, it will be used later in the process.

More information [here] ([**Access Key ID** and **Secret Access Key**] (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html?icmpid=docs_iam_console#Using_CreateAccessKey)) from AWS doc.


### Enable ROSA in your AWS account
If you haven’t done so already, visit [https://console.aws.amazon.com/rosa/home](https://console.aws.amazon.com/rosa/home){target:"_blank"}  to enable ROSA in your AWS account. 

### Download and install the ROSA command line tool
Visit [https://console.redhat.com/openshift/create/rosa/welcome](https://console.redhat.com/openshift/create/rosa/welcome) and at the step 2, select the proper Operating System and then download it tool. 

### Download and configure AWS CLI

1. Vist [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and Download AWS CLI.

2. Configure the AWS
    ```sh
    aws configure
    ```

    
Previously prepared **AWS Access Key Id** and **Secret Access Key** will be used here.

### Login with ROSA
   
You will be asked for providing an API token, get a token from [https://console.redhat.com/openshift/token/rosa](https://console.redhat.com/openshift/token/rosa).
```sh
rosa login
```

### Verify your credentials and quota
```sh
rosa whoami
```
```sh
rosa verify quota
```

If you are getting some error, please check your AWS account or the `aws configure`.    

### Deploy the cluster
```sh
rosa create account-roles --mode auto --yes
```
```sh
rosa create cluster --cluster-name <cluster-name> --sts --mode auto --yes
```
For more information, please refer to [https://www.rosaworkshop.io/rosa/2-deploy/](https://www.rosaworkshop.io/rosa/2-deploy/) to deploy the cluster on AWS.

### Create an Admin user

```sh
rosa create admin --cluster=<cluster-name>
```

The user namd and password will be display on the console.
You will need to wait for a little while when you use the user name/password to login.


### Get Openshift Webconsole URL
```sh
rosa describe cluster -c <cluster-name> | grep Console
```

Now you can use the above URL and user/password to login.

---

## Install Cloud Pak for Data
- Update `cpd-vars.sh`
- Run `source ./cpd-vars.sh`
- Log in to the cluster `cpd-cli manage login-to-ocp --token=${OCP_TOKEN}  --server=${OCP_URL}`
- Create the OLM objects `cpd-cli manage apply-olm --release=${VERSION} --components=${COMPONENTS}`
- Patch namespace scope
```
    oc patch NamespaceScope common-service -n ${PROJECT_CPFS_OPS} --type=merge --patch='{"spec": {"csvInjector": {"enable": true} } }'
```
- Install the CP4D components
```
cpd-cli manage apply-cr --components=${COMPONENTS} --release=${VERSION} --cpd_instance_ns=${PROJECT_CPD_INSTANCE} --block_storage_class=${STG_CLASS_BLOCK} --file_storage_class=${STG_CLASS_FILE} --license_acceptance=true
```

---

## Create EFS and NFS storage
1. Create EFS on AWS console
2. Create Security Group to allow inbound port 2049 to the EFS
3. Assign the Security Group to EFS instance
4. Follow the instruction on [IBM Knowledge Center](https://www.ibm.com/docs/en/cloud-paks/cp-data/4.5.x?topic=storage-setting-up-amazon-elastic-file-system).


## AWS NLB Setting
By default, ROSA security group some port number can not get thru to the OCP pod.
To fix it,
1. Create NodePort service
2. Add the port on the node to the security group, with CIDR block `0.0.0.0/0`
3. Use NLB with Elastic IP(Static IP), and using the node port

## Add Work Nodes
To add new work nodes by creating a new machinepool, where you can specify a instance type. 
```
rosa create machinepool --cluster=<cluster-name> --name=<machinepool-name> --instance-type=<ec2-instance-type> --replicas=<number-nodes>
```

You can modify existing machinepool replica counts to increase or recude the number of work nodes.
```
rosa edit machinepool <machinepool_id> --replicas <count>
```
