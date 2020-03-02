#!/bin/sh

STACK_ROLE_NAME="polly-lambda-iam-role"
STACK_BUCKET_NAME="polly-audio-bucket-stack"

# get the value of the first parameter
FUNCTION_NAME=$1

# package the lambda code
zip -r my_lambda lambda_function_polly.py

# create IAM role
aws cloudformation deploy --template-file templates/iam-role.yaml \
                          --stack-name $STACK_ROLE_NAME \
                          --region eu-west-1 \
                          --capabilities CAPABILITY_NAMED_IAM

# get the ARN of the IAM role
ROLE_ARN=$(aws cloudformation describe-stacks --stack-name $STACK_ROLE_NAME \
                                              --query 'Stacks[0].Outputs[?OutputKey==`LambdaExecutionRoleArn`].OutputValue' \
                                              --out text)

# create s3 bucket
aws cloudformation deploy --template-file templates/s3-bucket.yaml --stack-name $STACK_BUCKET_NAME --region eu-west-1

# create a new lambda function
aws lambda create-function --function-name $FUNCTION_NAME \
                           --runtime python3.6 \
                           --handler lambda_function_polly.lambda_handler \
                           --role $ROLE_ARN \
                           --zip-file fileb://my_lambda.zip

# clean the zip file
rm my_lambda.zip