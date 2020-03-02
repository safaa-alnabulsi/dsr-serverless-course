#!/bin/sh

STACK_ROLE_NAME="hello-world-lambda-iam-role"
STACK_BUCKET_NAME="polly-audio-bucket-stack"
BUCKET_NAME="polly-audiofiles-bucket"

# get the value of the first parameter
FUNCTION_NAME=$1

# clean the lambda function
aws lambda delete-function --function-name $FUNCTION_NAME

# clean the iam role
aws cloudformation delete-stack --stack-name $STACK_ROLE_NAME

# empty the s3 bucket
aws s3 rm s3://$BUCKET_NAME/* --recursive

# clean the s3 bucket
aws cloudformation delete-stack --stack-name $STACK_BUCKET_NAME
