#!/bin/sh

STACK_ROLE_NAME="hello-world-lambda-iam-role"

# get the value of the first parameter
FUNCTION_NAME=$1

# package the lambda code
zip -r my_lambda lambda_function.py

# create IAM role
echo "Creating the IAM Role"
aws cloudformation deploy --template-file templates/iam-role.yaml \
                          --stack-name $STACK_ROLE_NAME \
                          --region eu-west-1 \
                          --capabilities CAPABILITY_NAMED_IAM

# get the ARN of the IAM role
ROLE_ARN=$(aws cloudformation describe-stacks --stack-name $STACK_ROLE_NAME \
                                              --query 'Stacks[0].Outputs[?OutputKey==`LambdaExecutionRoleArn`].OutputValue' \
                                              --out text)

# create a new lambda function
echo "Creating the lambda function"
aws lambda create-function --function-name $FUNCTION_NAME \
                           --runtime python3.6 \
                           --handler lambda_function.lambda_handler \
                           --role $ROLE_ARN \
                           --zip-file fileb://my_lambda.zip

# clean the zip file
rm my_lambda.zip
