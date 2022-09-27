# Cloud Pak for Data 4.5 Install on ROSA

## Pre-requisites
### Workstation
- [ ] Docker or Podman
- [ ] Cpd-cli 
- [ ] Ansible
- [ ] OCP CLI
- [ ] Access to `icr.io`


### ROSA
- [ ] 3 Master Nodes with 8vCPU and 32GB RAM
- [ ] 5 Worker Nodes with 16vCPU and 64GB RAM
- [ ] OCP 4.8+

 
## Install fundational services
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




## AWS NLB Setting
By default, ROSA security group some port number can not get thru to the OCP pod.
To fix it,
1. Create NodePort service
2. Add the port on the node to the security group, with CIDR block `0.0.0.0/0`
3. Use NLB with Elastic IP(Static IP), and using the node port