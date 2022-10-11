## Install Cloud Pak for Data
- Review and update `scripts/vars.sh`.
  - Please check if there is file storage on Openshift Console: `Storage` -> `StorageClasses`, if all names start with `gp`, then please follow the instruction from `4. Post Install Config`->`Create EFS storage` to create an EFS storage, click [here](post-install.md) .
  - The variables need to be updated:
    - OCP_URL
    - OCP_TOKEN
    - STG_CLASS_FILE
    - IBM_ENTITLEMENT_KEY
- Run `source scripts/vars.sh`
- Log in to the cluster `cpd-cli manage login-to-ocp --token=${OCP_TOKEN}  --server=${OCP_URL}`
- Update global image pull secret `cpd-cli manage add-icr-cred-to-global-pull-secret ${IBM_ENTITLEMENT_KEY}`.
- Create the OLM objects `cpd-cli manage apply-olm --release=${VERSION} --components=${COMPONENTS}`. 
  - (it may take ~ 13 mins)
- Patch namespace scope
    ```
    oc patch NamespaceScope common-service -n ${PROJECT_CPFS_OPS} --type=merge --patch='{"spec": {"csvInjector": {"enable": true} } }'
    ```
- Install the CP4D components
    ```
    cpd-cli manage apply-cr --components=${COMPONENTS} --release=${VERSION} --cpd_instance_ns=${PROJECT_CPD_INSTANCE} --block_storage_class=${STG_CLASS_BLOCK} --file_storage_class=${STG_CLASS_FILE} --license_acceptance=true
    ```
    - (It may take ~ 90 mins)
