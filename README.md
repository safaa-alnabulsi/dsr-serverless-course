# Serverless Course

## Pre-requisites
- conda
- aws cloud account 

## Preparing your local env

To create python3.6 virtual env, use

	$ conda create -n myenvpy3.6 python=3.6
	
	
To activate this environment, use

     $ conda activate myenvpy3.6


To install needed libraries, use
 
     $ pip install -r requirements.txt
     

Before using aws-cli, you need to tell it about your AWS credentials. 

	$ aws configure
	AWS Access Key ID: foo
	AWS Secret Access Key: bar
	Default region name [us-west-2]: eu-west-1
	Default output format [None]: json
 
    
To deactivate an active environment, use

     $ conda deactivate


## Create & use lambda using aws-cli
1) Create an archive by zipping your code:


     $ zip -r my_lambda lambda_function.py

2) Create an IAM Role for AWS Lambda, you need Admin user to do that:


  	$ aws cloudformation deploy --template-file cfn/iam-role.yaml --stack-name slambda-iam-role --region eu-west-1 --capabilities CAPABILITY_NAMED_IAM

2) To get the IAM Role Arn, use:


	$ ROLE_ARN=$(aws cloudformation describe-stacks --stack-name slambda-iam-role --query 'Stacks[0].Outputs[?OutputKey==`LambdaExecutionRoleArn`].OutputValue' --out text)
    $ echo $ROLE_ARN
    
3) Create a lambda:

	 
	 $ aws lambda create-function --function-name safaa-function-from-cli --runtime python3.6 --handler lambda_function.lambda_handler  --role $ROLE_ARN --zip-file fileb://my_lambda.zip
	 
       {
           "FunctionName": "safaa-function-from-cli",
           "FunctionArn": "arn:aws:lambda:eu-west-1:410896695229:function:safaa-function-from-cli",
           "Runtime": "python3.6",
           "Role": "arn:aws:iam::410896695229:role/slambda-iam-role-LambdaExecutionRole-XL1IY6FM7DOJ",
           "Handler": "lambda_function.handler",
           "CodeSize": 395,
           "Description": "",
           "Timeout": 3,
           "MemorySize": 128,
           "LastModified": "2019-12-29T21:21:10.800+0000",
           "CodeSha256": "32AGoVJBnBMZznrk04JmLuh6ADgtSca3iQ0VgB7+wVQ=",
           "Version": "$LATEST",
           "TracingConfig": {
               "Mode": "PassThrough"
           },
           "RevisionId": "89647bd6-fa26-490c-a25b-4644c5b9d377",
           "State": "Active",
           "LastUpdateStatus": "Successful"
       }
       
4) Invoke the lambda:


	$ aws lambda invoke --function-name safaa-function-from-cli out --log-type Tail
	{
	    "StatusCode": 200,
	    "FunctionError": "Unhandled",
	    "LogResult": "U1RBUlQgUmVxdWVzdElkOiA1MTdlY2U4Ni00OTRlLTQwNTQtOTYzZC01OWYzYmZlZWFiODkgVmVyc2lvbjogJExBVEVTVApVbmFibGUgdG8gaW1wb3J0IG1vZHVsZSAnbGFtYmRhX2Z1bmN0aW9uJzogTm8gbW9kdWxlIG5hbWVkICdsYW1iZGFfZnVuY3Rpb24nCgpFTkQgUmVxdWVzdElkOiA1MTdlY2U4Ni00OTRlLTQwNTQtOTYzZC01OWYzYmZlZWFiODkKUkVQT1JUIFJlcXVlc3RJZDogNTE3ZWNlODYtNDk0ZS00MDU0LTk2M2QtNTlmM2JmZWVhYjg5CUR1cmF0aW9uOiAwLjQwIG1zCUJpbGxlZCBEdXJhdGlvbjogMTAwIG1zCU1lbW9yeSBTaXplOiAxMjggTUIJTWF4IE1lbW9yeSBVc2VkOiA1MCBNQglJbml0IER1cmF0aW9uOiAwLjkxIG1zCQo=",
	    "ExecutedVersion": "$LATEST"
	}
	
5) Notice the `out` file in your local machine, Check the logs locally:


    $ aws lambda invoke --function-name safaa-function-from-cli  out --log-type Tail --query 'LogResult' --output text |  base64 -D
    START RequestId: 524ed3c5-ce0c-4f69-b1ef-2526431e4e41 Version: $LATEST
    Loading function
    END RequestId: 524ed3c5-ce0c-4f69-b1ef-2526431e4e41
    REPORT RequestId: 524ed3c5-ce0c-4f69-b1ef-2526431e4e41	Duration: 0.27 ms	Billed Duration: 100 ms	Memory Size: 128 MB	Max Memory Used: 50 MB	Init Duration: 1.05 ms


5) Change the code of the lambda to recieve inputs, and redeploy (Note that you have to repackage the lambda and update the code):
    
    
    $ zip -r my_lambda lambda_function.py
    
    $ aws lambda update-function-code --function-name safaa-function-from-cli --zip-file fileb://my_lambda.zip
    
    $ aws lambda invoke --function-name safaa-function-from-cli --payload '{"key1": "value1 of key1"}' out --log-type Tail --query 'LogResult' --output text |  base64 -D
    START RequestId: 7c79341c-86ca-4066-b745-5975faedb446 Version: $LATEST
    inside the lambda function
    value1 =  value1 of key1
    END RequestId: 7c79341c-86ca-4066-b745-5975faedb446
    REPORT RequestId: 7c79341c-86ca-4066-b745-5975faedb446	Duration: 0.22 ms	Billed Duration: 100 ms	Memory Size: 128 MB	Max Memory Used: 50 MB	Init Duration: 0.89 ms

7) Check it all in the console.

### to update the function code, use:

    $ aws lambda update-function-code --function-name safaa-function-from-cli --zip-file fileb://my_lambda.zip

### to clean up, use:

    $ aws lambda delete-function --function-name safaa-function-from-cli

## References
- [aws-cli](https://github.com/aws/aws-cli#getting-started)
- [Creating a role with the conosle](https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html)