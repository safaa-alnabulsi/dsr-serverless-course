# DSR Serverless Course (AWS Lambda)

## Pre-requisites

- [Git](https://github.com/git-guides/install-git)
    - macOS: `brew install git`
    - Linux (Ubuntu): `sudo apt-get update && sudo apt-get install git-all` 
- conda
    - [macOS](https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html#) 
    - [Linux (Ubuntu)](https://docs.anaconda.com/anaconda/install/linux/)

## Creating AWS Account

Follow the instructions in [this page](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

## Preparing your local env

Clone the github repo 

    $ git clone git@github.com:safaa-alnabulsi/dsr-serverless-course.git
    cd dsr-serverless-course
    
Create python3.6 virtual env, use

    $ conda create -n dsr-serverless-py36 python=3.6 -y
	
	
Activate this environment, use

     $ conda activate dsr-serverless-py36


Install needed libraries, use
 
     $ pip install -r requirements.txt
     
_Note:_ to deactivate an active environment, use

     $ conda deactivate

Intall `zip` command:  
  - Ubuntu:  `sudo apt-get install -y zip`
  - Manjaro: `sudo pacman -S zip` 
  
  	Note: In case if you get any error while installing the package, try the command below and repeat the previous commands `sudo pacman -Rs zip` 


## Configuring your local CLI with AWS

Before using aws-cli, you need to configure it with your AWS credentials.
You can create a user in https://console.aws.amazon.com/iam/ and export the credentials csv.
If the user name is `cli-user`, run the following:

	$ aws configure --profile cli-user
	AWS Access Key ID: foo
	AWS Secret Access Key: bar
	Default region name [us-west-2]: eu-west-1
	Default output format [None]: json

	$ export AWS_PROFILE=cli-user

If you have an issue 

To test if you have access, run the following and you shouldn't see an error:
	
	$ aws s3 ls

Note:
If you have an issue in using the aws command try the following way in doing the setup:

    $ cat > ~/.aws/config
    [default]
    region=us-west-2
    aws_access_key_id=foo
    aws_secret_access_key=bar
    
    $ aws configure
    AWS Access Key ID [****************foo]:
    AWS Secret Access Key [****************bar]:
    Default region name [us-west-2]:
    Default output format [None]:

Note: 
using the new AWS CLI version 2 Docker image might not work with all examples. 

## Tutorials & Labs

### Introduction

 To learn more, follow this tutorial [00-intro.md](tutorials/00-intro.md)

### AWS Console General Introduction

 To learn more, follow this tutorial [01-aws-console-general-intro.md](tutorials/01-aws-console-general-intro.md)

###  Create lambda from a blurprint using aws console

 To learn more, follow this tutorial [02-create-lambda-from-blueprint-with-aws-console.md](tutorials/02-create-lambda-from-blueprint-with-aws-console.md)

### Create lambda from scratch using aws console
 
 To learn more, follow this tutorial [03-create-lambda-from-scratch-with-aws-console.md](tutorials/03-create-lambda-from-scratch-with-aws-console.md)

### Create & use lambda using aws-cli
    
 To learn more, follow this tutorial [04-create-lambda-with-aws-cli.md](tutorials/04-create-lambda-with-aws-cli.md)

### Easy setup and deployment using shell scripts
    
 To learn more, follow this tutorial [05-create-lambda-with-aws-cli-and-shell-scripts.md](tutorials/05-create-lambda-with-aws-cli-and-shell-scripts.md)
  
### Text to speech example, using boto3 (Python SDK) 
   
 To learn more, follow this tutorial [06-text-to-speech-lambda-boto3-and-polly.md](tutorials/06-text-to-speech-lambda-boto3-and-polly.md)
   
## References
- [aws-cli docs](https://github.com/aws/aws-cli#getting-started)
- [Python SDK - Boto3 docs](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
- [Boto3 Polly, synthesize_speech](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/polly.html#Polly.Client.synthesize_speech)
- [Creating a role with the console](https://docs.aws.amazon.com/lambda/latest/dg/lambda-intro-execution-role.html)
- [Cloudformation IAM role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html)
- [Cloudformation S3 bucket](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html)
- [AWS Lambda Pricing](https://aws.amazon.com/lambda/pricing/)
