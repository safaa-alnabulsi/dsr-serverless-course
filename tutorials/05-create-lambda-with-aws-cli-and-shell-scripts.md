# Create & use lambda using aws-cli, all in one shell script
    
    cd example-5-hello-world-scripts

To create a new lambda and a role:

    . scripts/setup.sh example-5-hello-world

![Screenshot](architecture/setup-lambda.png)

To deploy a lambda and invoke it:

    . scripts/deploy.sh example-5-hello-world '{"key1": "my-value"}'
    
![Screenshot](architecture/invoke-lambda.png)


Note: Don't forget to clean your stacks by executing:

    . scripts/clean.sh example-5-hello-world
    
Note: to make a shell script executable, use:

    chmod +x scripts/deploy.sh  
    
Note: for linux, try changing the script and use `base64 -d`

## Takeaways:

- Use Shell Script to automate the deployment.
