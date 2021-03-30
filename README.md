# terraform-eks
Terraform eks setup and k8s deployments

##Steps##

Start container
`docker run -it --rm -v $(pwd):/work terraform:v1 /bin/bash`

Connect to aws - create credentials on aws console - set output to json
`aws configue`

Test Terraform config
`terraform plan`

