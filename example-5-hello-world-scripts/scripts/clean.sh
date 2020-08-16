#!/bin/sh

STACK_ROLE_NAME="hello-world-lambda-iam-role"

# get the value of the first parameter
FUNCTION_NAME=$1

# clean the lambda function
aws lambda delete-function --function-name $FUNCTION_NAME

# clean the iam role
aws cloudformation delete-stack --stack-name $STACK_ROLE_NAME
