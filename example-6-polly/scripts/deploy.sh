#!/bin/sh

# get the value of the first parameter
FUNCTION_NAME=$1

# get the value of the second parameter
PAYLOAD=$2

# package the lambda code
zip -r my_lambda_polly lambda_function_polly.py

# update the lambda function after changing its code
echo "Updating the lambda function code"
aws lambda update-function-code --function-name $FUNCTION_NAME --zip-file fileb://my_lambda_polly.zip

# invoke the lambda, decode and show the logs
echo "Invoking the lambda function"
aws lambda invoke --function-name $FUNCTION_NAME --payload "$PAYLOAD" out --log-type Tail --query 'LogResult' --output text |  base64 -d

# clean the zip file
rm my_lambda_polly.zip

# clean the log file
rm out
