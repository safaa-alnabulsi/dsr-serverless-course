#!/bin/sh

FUNCTION_NAME=$1
STACK_ROLE_NAME="slambda-iam-role"

zip -r my_lambda lambda_function.py

aws cloudformation deploy --template-file cfn/iam-role.yaml --stack-name $STACK_ROLE_NAME --region eu-west-1 --capabilities CAPABILITY_NAMED_IAM

ROLE_ARN=$(aws cloudformation describe-stacks --stack-name $STACK_ROLE_NAME --query 'Stacks[0].Outputs[?OutputKey==`LambdaExecutionRoleArn`].OutputValue' --out text)

aws lambda create-function --function-name $FUNCTION_NAME --runtime python3.6 --handler lambda_function.lambda_handler --role $ROLE_ARN --zip-file fileb://my_lambda.zip

rm my_lambda.zip