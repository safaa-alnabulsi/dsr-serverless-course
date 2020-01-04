#!/bin/sh

zip -r my_lambda lambda_function.py

aws lambda update-function-code --function-name safaa-function-from-cli --zip-file fileb://my_lambda.zip

aws lambda invoke --function-name safaa-function-from-cli --payload '{"key1": "value1 of key1"}' out --log-type Tail --query 'LogResult' --output text |  base64 -D