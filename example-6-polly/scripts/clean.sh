#!/bin/sh

STACK_ROLE_NAME="polly-lambda-iam-role"
STACK_BUCKET_NAME="polly-audio-bucket-stack"

# get the value of the first parameter
FUNCTION_NAME=$1

# get the value of the second parameter
BUCKET_NAME=$2

# clean the lambda function
aws lambda delete-function --function-name $FUNCTION_NAME

# clean the iam role
aws cloudformation delete-stack --stack-name $STACK_ROLE_NAME

# empty the s3 bucket && clean the s3 bucket
aws s3 rm s3://$BUCKET_NAME --recursive && aws cloudformation delete-stack --stack-name $STACK_BUCKET_NAME
