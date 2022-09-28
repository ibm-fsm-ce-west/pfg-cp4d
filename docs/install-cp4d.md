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
