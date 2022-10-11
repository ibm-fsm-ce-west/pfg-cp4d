## Create EFS storage
1. Create EFS on AWS console
2. Find Security Group used by EFS and add inbound rule 2049 to the EFS
3. If no Security Group from above step, then create a new Security Group and assign it to EFS instance
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