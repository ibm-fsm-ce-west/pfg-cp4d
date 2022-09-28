## Setup ROSA

### AWS Configure Identity and Access Management (IAM) 
This configuration is set on AWS web console. We will need to get **Access Key ID** and **Secret Access Key** in this step.

1. Click on search bar in the upper left hand corner and search for `IAM`.
2. On the left hand side, click `Users` and then click your username.
3. Click the `Security credentials` secion and click `Create access Key`.
4. Copy and save the **Access Key ID** and **Secret Access Key**, it will be used later in the process.

More information [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html?icmpid=docs_iam_console#Using_CreateAccessKey).


### Enable ROSA in your AWS account
If you haven’t done so already, visit [https://console.aws.amazon.com/rosa/home](https://console.aws.amazon.com/rosa/home) to enable ROSA in your AWS account. 


### Configure the AWS
You will be asked to enter **Access Key ID** and **Secret Access Key**, previously prepared **AWS Access Key Id** and **Secret Access Key** will be used here.
```
aws configure
```
   


### Login with ROSA
   
You will be asked for providing an API token, get a token from [https://console.redhat.com/openshift/token/rosa](https://console.redhat.com/openshift/token/rosa).
```
rosa login
```

### Verify your credentials and quota
```
rosa whoami
```
```
rosa verify quota
```

If you are getting some error, please check your AWS account or the `aws configure`.    

### Deploy the cluster
```
rosa create account-roles --mode auto --yes
```
```
rosa create cluster --cluster-name <your-cluster-name> --sts --mode auto --enable-autoscaling  --min-replicas 2 --max-replicas 5 --compute-machine-type <ec2-instance-type> --yes
```
For more information, please refer to [https://www.rosaworkshop.io/rosa/2-deploy/](https://www.rosaworkshop.io/rosa/2-deploy/) to deploy the cluster on AWS.

EC2 instance types can be found here: [https://aws.amazon.com/ec2/instance-types](https://aws.amazon.com/ec2/instance-types/).


### Create an Admin user

```sh
rosa create admin --cluster=<cluster-name>
```

The user namd and password will be display on the console.
You will need to wait for a little while when you use the user name/password to login.


### Get Openshift Webconsole URL
```
rosa describe cluster -c <cluster-name> | grep Console
```

Now you can use the above URL and user/password to login.
