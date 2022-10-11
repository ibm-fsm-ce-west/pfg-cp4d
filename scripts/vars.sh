#===============================================================================
# Cloud Pak for Data installation variables
#===============================================================================

# ------------------------------------------------------------------------------
# Cluster
# ------------------------------------------------------------------------------

export OCP_URL=https://api.dfs-rosa.ktwp.p1.openshiftapps.com:6443
export OPENSHIFT_TYPE=rosa
export OCP_USERNAME=cluster-admin
export OCP_PASSWORD=xxxxxx

# The token can be found from OpenShift Console, top-right corner, click the user name 
# then select "Copy login command", a popup window will show the a token
export OCP_TOKEN=sha256~GNubBG2HrMpzPA6FedNLEX_OlzpI5Fpj8eAu1C2f0pI


# ------------------------------------------------------------------------------
# Projects
# ------------------------------------------------------------------------------
# No need to change this section
export PROJECT_CPFS_OPS=ibm-common-services        
export PROJECT_CPD_OPS=ibm-common-services
export PROJECT_CATSRC=openshift-marketplace
export PROJECT_CPD_INSTANCE=cp4d
# export PROJECT_TETHERED=<enter the tethered project>


# ------------------------------------------------------------------------------
# Storage
# ------------------------------------------------------------------------------
## Please dobule check the available storage classes on ROSA cluster
export STG_CLASS_BLOCK=gp3-csi
export STG_CLASS_FILE=ocs-storagecluster-cephfs

# ------------------------------------------------------------------------------
# IBM Entitled Registry
# ------------------------------------------------------------------------------
# The entitlement key can be found from "myibm.ibm.com"
export IBM_ENTITLEMENT_KEY=<Entitlement key>


# ------------------------------------------------------------------------------
# Private container registry
# ------------------------------------------------------------------------------
# Set the following variables if you mirror images to a private container registry.
#
# To export these variables, you must uncomment each command in this section.

# export PRIVATE_REGISTRY_LOCATION=<enter the location of your private container registry>
# export PRIVATE_REGISTRY_PUSH_USER=<enter the username of a user that can push to the registry>
# export PRIVATE_REGISTRY_PUSH_PASSWORD=<enter the password of the user that can push to the registry>
# export PRIVATE_REGISTRY_PULL_USER=<enter the username of a user that can pull from the registry>
# export PRIVATE_REGISTRY_PULL_PASSWORD=<enter the password of the user that can pull from the registry>


# ------------------------------------------------------------------------------
# Cloud Pak for Data version
# ------------------------------------------------------------------------------

export VERSION=4.5.2


# ------------------------------------------------------------------------------
# Components
# ------------------------------------------------------------------------------
# Set the following variable if you want to install or upgrade multiple components at the same time.
#
# To export the variable, you must uncomment the command.


#export COMPONENTS=cpfs,scheduler,cpd_platform
export COMPONENTS=cpfs,scheduler,cpd_platform,db2oltp,datagate