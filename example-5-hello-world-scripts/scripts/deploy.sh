#!/bin/sh

# get the value of the first parameter
FUNCTION_NAME=$1

# get the value of the second parameter
PAYLOAD=$2

# package the lambda code
zip -r my_lambda *.py

# update the lambda function after changing its code
echo "Updating the lambda code"
aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://my_lambda.zip

# invoke the lambda, decode and show the logs
echo "Invoking the lambda"
aws lambda invoke --function-name $FUNCTION_NAME --payload "$PAYLOAD" out --log-type Tail --query 'LogResult' --output text |  base64 -D

# clean the zip file
rm my_lambda.zip

# clean the log file
rm out
