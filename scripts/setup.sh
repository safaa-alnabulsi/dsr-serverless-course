#!/bin/sh

zip -r my_lambda lambda_function.py

aws cloudformation deploy --template-file cfn/iam-role.yaml --stack-name slambda-iam-role --region eu-west-1 --capabilities CAPABILITY_NAMED_IAM

ROLE_ARN=$(aws cloudformation describe-stacks --stack-name slambda-iam-role --query 'Stacks[0].Outputs[?OutputKey==`LambdaExecutionRoleArn`].OutputValue' --out text)

aws lambda create-function --function-name safaa-function-from-cli --runtime python3.6 --handler lambda_function.lambda_handler  --role $ROLE_ARN --zip-file fileb://my_lambda.zip

