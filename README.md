# Deploy Kubernetes cluster and web app using terraform on AWS
## Horizontal pod autoscaler also configured

Terraform eks setup and k8s deployments

*Steps*

Build container with all software needed (AWS CLI, Terraform, kubectl)

`docker build -t terraform:v1 .`

Start container

`docker run -it --rm -v $(pwd):/work terraform:v1 /bin/bash`

Connect to aws - create credentials on aws console - set output to json

`aws configure`

Test Terraform config

`terraform init`

`terraform plan`

Apply Terraform config

`terraform apply`

Load kubecfg from aws

`aws eks update-kubeconfig --name <cluster_name> --region eu-west-2`

Test kubectl

`kubectl get nodes`

`kubectl get svc`

Generate load

`docker run --rm jgoclawski/wget:latest /bin/sh -c "while sleep 0.01; do wget -q -O- http://awsurl; done"`

Delete everything

`terraform destroy`
