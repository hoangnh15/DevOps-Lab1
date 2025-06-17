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