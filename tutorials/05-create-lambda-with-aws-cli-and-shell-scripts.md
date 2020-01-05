# Create & use lambda using aws-cli, all in one shell script
    
To create a new lambda and a role:

    $ . scripts/setup.sh function-name

![Screenshot](architecture/setup-lambda.png)

To deploy a lambda and invoke it:

    $ . scripts/deploy.sh function-name '{"key1": "value1 of key1"}'
    
![Screenshot](architecture/invoke-lambda.png)

Note: to make a shell script executable, use:

    $ chmod +x scripts/deploy.sh  
    