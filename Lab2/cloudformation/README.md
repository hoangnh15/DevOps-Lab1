# NT548-lab2-group14-CloudFormation-CodePipeline
NT548-lab2-group14-CloudFormation-CodePipeline

Members of group 14:
| MSSV | FullName | Email |
|-------------|-----------------------|---------------------------------|
| 21522094 | Nguyễn Huy Hoàng | 21522094@gm.uit.edu.vn |
| 21522701 |    Hồ Minh Trí   | 21522701@gm.uit.edu.vn |

STEP:
- git clone
- aws configure
- make Github Token and save it in Secret AWS 
- make s3 bucket with cloudformation-modules name
- aws s3 cp [Name of modules].yml s3://cloudformation-modules
- aws cloudformation delete-stack --stack-name [Name of Stack]
- aws cloudformation create-stack --template-body file://[URL to the sample file in your PC] --stack-name [Name of Stack] --capabilities CAPABILITY_NAMED_IAM --parameter-overrides GitHubOwner=[GitHub Username]

## Networking Diagram

Below is a conceptual networking diagram illustrating the setup:

```
+-------------------+       +-------------------+
|   Public Subnet   |       |   Private Subnet  |
|                   |       |                   |
|  +-------------+  |       |  +-------------+  |
|  |  EC2 Public |  |       |  | EC2 Private |  |
|  |  Instance   |  |       |  |  Instance   |  |
|  +-------------+  |       |  +-------------+  |
|       |           |       |                   |
|       | ElasticIP |       |                   |
+-------+-----------+       +-------------------+
        |                           |
        +---------------------------+
        |                           |
+-------v---------------------------v-------+
|                VPC                        |
|                                           |
|  +-----------------+   +----------------+ |
|  | Internet Gateway|   |   NAT Gateway  | |
|  +-----------------+   +----------------+ |
|                                           |
+-------------------------------------------+
```

- **Public Subnet**: Contains the public EC2 instance with an Elastic IP, allowing it to communicate with the internet.
- **Private Subnet**: Contains the private EC2 instance, which can only communicate with the internet through the NAT Gateway.
- **Internet Gateway**: Provides internet access to resources in the public subnet.
- **NAT Gateway**: Allows resources in the private subnet to access the internet without exposing them to inbound traffic.


## Deploy AWS CodePipeline 

### Step 1: Clone and Push Source code from this repository into CodeCommit

### Step 2: Create Project from AWS CodeBuild

### Step 3: Create Pipeline to Deploy AWS infrastructure with CloudFormation 