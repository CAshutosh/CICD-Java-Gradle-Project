Pipeline Overview -

Our CI/CD pipeline is designed to automate the build and deployment process for our application using DevOps tools. The pipeline consists of the following stages:

1. Quality Gate Status Check:
This stage checks the code quality using SonarQube, which is a tool for continuous code quality inspection. It uses the 'maven' docker image and mounts the Maven       local repository to avoid re-downloading dependencies. It runs the 'mvn sonar:sonar' command, which analyzes the code and sends the results to SonarQube for review. If the quality gate is not passed, the pipeline is aborted with an error message. Otherwise, the code is built and tested using 'mvn clean install'.

2. Docker build & Docker push:
In this stage, the Docker image for the application is built using the Dockerfile in the project directory. The image is then pushed to the Docker registry hosted at IP address '44.200.233.221:8083'. Jenkins pulls the Docker credentials from a Jenkins credential store and logs in to the registry. Once logged in, the built image is pushed to the registry, and the image is then deleted from the local machine.

3. Deploy:
The final stage of the pipeline deploys the application to a Kubernetes cluster using Ansible. The deployment file for the Kubernetes cluster is located at '/kubernetes-manifest/Deployment.yaml', and the pipeline updates the image tag with the version number obtained from the previous stage. Ansible then performs the deployment using the inventory specified in the 'hosts' file and the playbook 'Ansible.yaml'.

We are using Terraform to provision our infrastructure.

![MicrosoftTeams-image (34)](https://user-images.githubusercontent.com/123365436/222364108-d8c23a85-6f96-4a87-8857-2e500be4354b.png)
