# Cloud Pak for Data 4.5 Install on ROSA

## Pre-requisites
### Workstation
- [x] Docker or Podman
- [x] Cpd-cli 
- [x] OCP CLI
- [x] Access to `icr.io`


### ROSA
- [x] 3 Master Nodes with 8vCPU and 32GB RAM
- [x] 5 Worker Nodes with 16vCPU and 64GB RAM
- [x] OCP 4.8+

## AWS Configuration 
### Create Hosted Zone on AWS Route 53
This can be done on AWS web console.  You will need a domain or subdomain for this configuration.

1. Navigate to `Route 53` -> `Hosted Zones`.
1. Select `Create host zone` and then enter the domain/subdomain name.
1. Select Type - `Public hosted zone` and then create it.

The example below uses the subdomain `itz-aws.c14.me`.

### Configure the DNS 
Once the Route 53 Hosted Zone is created, it will generate some records. All the type `NS` records need to be configured in the DNS.

### Configure Identity and Access Management (IAM) 
This configuration is set on AWS web console. We will need to get **Access Key ID** and **Secret Access Key** in this step.

1. Click on search bar in the upper left hand corner and search for `IAM`.
2. On the left hand side, click `Users` and then click your username.
3. Click the `Security credentials` secion and click `Create access Key`.
4. Copy and save the **Access Key ID** and **Secret Access Key**, it will be used later in the process.

More information [here] ([**Access Key ID** and **Secret Access Key**] (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html?icmpid=docs_iam_console#Using_CreateAccessKey)) from AWS doc.


## Install foundational services
1. Update `cpd-vars.sh`
1. Run `source ./cpd-vars.sh`
1. Log in to the cluster `cpd-cli manage login-to-ocp --token=${OCP_TOKEN}  --server=${OCP_URL}`
1. Create the OLM objects `cpd-cli manage apply-olm --release=${VERSION} --components=${COMPONENTS}`
1. Patch namespace scope
```
oc patch NamespaceScope common-service -n ${PROJECT_CPFS_OPS} --type=merge --patch='{"spec": {"csvInjector": {"enable": true} } }'
```
1. Install the CP4D components
```
cpd-cli manage apply-cr --components=${COMPONENTS} --release=${VERSION} --cpd_instance_ns=${PROJECT_CPD_INSTANCE} --block_storage_class=${STG_CLASS_BLOCK} --file_storage_class=${STG_CLASS_FILE} --license_acceptance=true
```

## Install Data Gate
1. Run the cpd-cli manage login-to-ocp command to log in to the cluster as a user with sufficient permissions to complete this task. For example:
```
cpd-cli manage login-to-ocp --token=${OCP_TOKEN}  --server=${OCP_URL}
```


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
