# terraform-eks
Terraform eks setup and k8s deployments

##Steps##

Start container
`docker run -it --rm -v $(pwd):/work terraform:v1 /bin/bash`

Connect to aws - create credentials on aws console - set output to json
`aws configue`

Test Terraform config
`terraform plan`

Apply Terraform config
`terraform apply`

Load kubecfg from aws
`aws eks update-kubeconfig --name pedro_cluster --region eu-west-2`

If export is needed
`export KUBECONFIG=/work/kubeconfig_pedro_cluster`

Test kubectl
`kubectl get nodes`
`kubectl get svc`

Delete everything
`terraform destroy`
