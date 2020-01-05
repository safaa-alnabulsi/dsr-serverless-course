# Text to speech example, using boto3 (Python SDK) 
    
To create a new lambda, the role and the s3 bucket:

    $ . scripts/setup-polly.sh function-name

![Screenshot](tutorials/architecture/setup-lambda-polly.png)

To deploy a lambda and invoke it:

    $ . scripts/deploy.sh function-name

![Screenshot](tutorials/architecture/invoke-lambda-polly.png)

Copy the url to your browser and download the file! 