# Serverless Course

## Pre-requisites
- git
- conda
- aws cloud account 

## Preparing your local env

Clone the github repo 

    $ git clone git@github.com:safaa-alnabulsi/dsr-serverless-course.git
    cd dsr-serverless-course
    
Create python3.6 virtual env, use

	$ conda create -n myenvpy3.6 python=3.6
	
	
Activate this environment, use

     $ conda activate myenvpy3.6


Install needed libraries, use
 
     $ pip install -r requirements.txt
     

Before using aws-cli, you need to tell it about your AWS credentials. 

	$ aws configure
	AWS Access Key ID: foo
	AWS Secret Access Key: bar
	Default region name [us-west-2]: eu-west-1
	Default output format [None]: json
 
    
To deactivate an active environment, use

     $ conda deactivate

## Tutorials & Labs

### Introduction

 To learn more, follow this tutorial [00-intro.md](tutorials/00-intro.md)

### AWS Console General Introduction

 To learn more, follow this tutorial [01-aws-console-general-intro.md](tutorials/01-aws-console-general-intro.md)

###  Create lambda from a blurprint using aws console

 To learn more, follow this tutorial [02-create-lambda-from-blueprint-with-aws-console.md](tutorials/02-create-lambda-from-blueprint-with-aws-console.md)

### Create lambda from scratch using aws console
 
 To learn more, follow this tutorial [03-create-lambda-from-scratch-with-aws-console.md](tutorials/03-create-lambda-from-scratch-with-aws-console.md)

### Easy setup and deployment using shell scripts
    
 To learn more, follow this tutorial [05-create-lambda-with-aws-cli-and-shell-scripts.md](tutorials/05-create-lambda-with-aws-cli-and-shell-scripts.md)
  
### Text to speech example, using boto3 (Python SDK) 
   
 To learn more, follow this tutorial [06-text-to-speech-lambda-boto3-and-polly.md](tutorials/06-text-to-speech-lambda-boto3-and-polly.md)
   
### To clean the created lambda and infra

    $ . scripts/clean.sh function-name 

## References
- [aws-cli docs](https://github.com/aws/aws-cli#getting-started)
- [Boto3 docs](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
- [Boto3 Polly, synthesize_speech](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/polly.html#Polly.Client.synthesize_speech)
- [Creating a role with the conosle](https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html)
- [Cloudformation IAM role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html)
- [Cloudformation S3 bucket](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html)