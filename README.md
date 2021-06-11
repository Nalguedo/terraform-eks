# terraform-eks
Terraform eks setup and k8s deployments

*Steps*

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

`aws eks update-kubeconfig --name pedro_cluster --region eu-west-2`

Test kubectl

`kubectl get nodes`

`kubectl get svc`

Delete everything

`terraform destroy`

Generate load

`docker run --rm jgoclawski/wget:latest /bin/sh -c "while sleep 0.01; do wget -q -O- http://awsurl; done"`

server metrics fix
 name      = "metrics-server:system:auth-delegator" 
 this should be auth-reader not auth-delegator. Seems like Copy&Paste bug

