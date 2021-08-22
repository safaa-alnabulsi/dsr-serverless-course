# Create & use lambda using aws-cli


```
cd example-4-hello-world-cli
```

1. Create an IAM Role for AWS Lambda, you need Admin user to do that:

```
aws cloudformation deploy --template-file templates/iam-role.yaml --stack-name slambda-iam-role --region eu-west-1 --capabilities CAPABILITY_NAMED_IAM
```

2. To get the IAM Role Arn, use:
```
ROLE_ARN=$(aws cloudformation describe-stacks --stack-name slambda-iam-role --query 'Stacks[0].Outputs[?OutputKey==`LambdaExecutionRoleArn`].OutputValue' --out text) && echo $ROLE_ARN
```

3. Create an archive by zipping your code:

```
zip -r my_lambda lambda_function.py
```

4. Create a lambda:
```
MY_NAME=$(whoami)
aws lambda create-function --function-name $MY_NAME-function-from-cli --runtime python3.6 --handler lambda_function.lambda_handler  --role $ROLE_ARN --zip-file fileb://my_lambda.zip
	 
{
    "FunctionName": "salnabulsi-function-from-cli",
    "FunctionArn": "arn:aws:lambda:eu-west-1:434405979992:function:salnabulsi-function-from-cli",
    "Runtime": "python3.6",
    "Role": "arn:aws:iam::434405979992:role/slambda-iam-role-LambdaExecutionRole-RE7ACGPZ3XSX",
    "Handler": "lambda_function.lambda_handler",
    "CodeSize": 344,
    "Description": "",
    "Timeout": 3,
    "MemorySize": 128,
    "LastModified": "2020-11-08T22:17:58.516+0000",
    "CodeSha256": "8vijcvNSB711jwkPFfPSqwSzzTNPS2eOqVrO3cBZoUA=",
    "Version": "$LATEST",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "613ec6b1-9b18-41a8-86b0-8561e399245a",
    "State": "Active",
    "LastUpdateStatus": "Successful"
}
```    
 
5. Invoke the lambda and notice the `out` file in your local machine folder. It contains the logs:
```
aws lambda invoke --function-name $MY_NAME-function-from-cli  out --log-type Tail --query 'LogResult' --output text |  Base64 -D
    START RequestId: 524ed3c5-ce0c-4f69-b1ef-2526431e4e41 Version: $LATEST
    Loading function
    END RequestId: 524ed3c5-ce0c-4f69-b1ef-2526431e4e41
    REPORT RequestId: 524ed3c5-ce0c-4f69-b1ef-2526431e4e41	Duration: 0.27 ms	Billed Duration: 100 ms	Memory Size: 128 MB	Max Memory Used: 50 MB	Init Duration: 1.05 ms
```

6. Change the code of the lambda to recieve inputs, and redeploy (Note that you have to repackage the lambda and update the code):
```
zip -r my_lambda lambda_function.py
    
aws lambda update-function-code --function-name $MY_NAME-function-from-cli --zip-file fileb://my_lambda.zip
    
aws lambda invoke --function-name $MY_NAME-function-from-cli --payload '{"key1": "value1 of key1"}' out --log-type Tail --query 'LogResult' --output text |  Base64 -D
    START RequestId: 7c79341c-86ca-4066-b745-5975faedb446 Version: $LATEST
    inside the lambda function
    value1 =  value1 of key1
    END RequestId: 7c79341c-86ca-4066-b745-5975faedb446
    REPORT RequestId: 7c79341c-86ca-4066-b745-5975faedb446	Duration: 0.22 ms	Billed Duration: 100 ms	Memory Size: 128 MB	Max Memory Used: 50 MB	Init Duration: 0.89 ms
``` 

Note: for linux, try using `base64 -d`

7. Check it all in the console.

### to update the function code, use:
```
zip -r my_lambda lambda_function.py && aws lambda update-function-code --function-name $MY_NAME-function-from-cli --zip-file fileb://my_lambda.zip
```
### to clean up, use:
```
aws lambda delete-function --function-name $MY_NAME-function-from-cli
```

## Takeaways:
- Infra as Code (Cloudformation)
- Usage of AWS CLI to create and update resources
