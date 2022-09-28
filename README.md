# Cloud Pak for Data 4.5 Install on ROSA

## Pre-requisites
### Workstation
- [x] ROSA CLI
- [x] AWS CLI
- [x] Docker or Podman
- [x] Cpd-cli 
- [x] OCP CLI
- [x] Access to `icr.io`

### ROSA Requirements
- [x] 3 Master Nodes with 8vCPU and 32GB RAM
- [x] 5 Worker Nodes with 16vCPU and 64GB RAM
- [x] OCP 4.8+

---
## Installation Steps

1. [Prepare Workstation](docs/prepare-workstation.md)
2. [Setup ROSA](docs/setup-rosa.md)
3. [Install CP4D](docs/install-cp4d.md)
4. [Post Install Config](docs/post-install.md)
