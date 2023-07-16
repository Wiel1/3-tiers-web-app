# Project SimpleEC2

Read the below in its entirety carefully before starting the implementation. Draw conceptualisation diagrams to make sure you have understood the requirements. Draft an implementation tasks list with each task clearly described and in roughly the order in which it will be implemented.
ONLY when you are satisfied with your pre implementation planning should you begin to implement.

1) Create a directory called simpleec2 in which you will have your terraform codebase. Create terraform files 
following the conventional pattern in the directory - it should have a structure similar to the below:

```
.
├── backend.tf
├── env
│   ├── prd
│   │   └── terraform.tfvars
│   └── test
│       └── terraform.tfvars
├── main.tf
├── modules
│   ├── alb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ec2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── s3
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── provider.tf
├── variables.tf
└── version.tf
```

(For now, put all your code in the root directory - do not use the modules directory yet. We will use the modules in 
subsequent assignments)

You will simulate creating resources for two environments (test and prd). So create two backend buckets in your
AWS account. These buckets will be used to hold your state for each environment;

1) technologiesoutcomes-<b>your-unique-name-here</b>-simpleec2-backend-test
2) technologiesoutcomes-<b>your-unique-name-here</b>-simpleec2-backend-prd

Write Terraform code to provision the following;

1) Network resources (one public subnet) for each environment (test and prd) - So a VPC for test,  a VPC for PRD.
We will put all the EC2 instances in the public subnet for now.

2) For each environment, create two EC2 instances using t2.micro and ubuntu in your public subnet. 
One instance will be the frontend and the other the backend. Label them accordingly.

For the Frontend instance use user data script to install one of the following applications.
* Installation and configuration of Apache HTTP server (https://opensource.com/article/18/2/apache-web-server-configuration)
OR
* Installation and configuration of Nginx (https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04)

For the Backend instance use user data script to install ALL these following applications.
* Installation and configuration of Tomcat on ubuntu 22-04 (https://linuxize.com/post/how-to-install-tomcat-10-on-ubuntu-22-04/)
*  Installation and configuration of Jenkins (https://phoenixnap.com/kb/install-jenkins-ubuntu)
* Installation and configuration of Maven (https://www.digitalocean.com/community/tutorials/install-maven-linux-ubuntu)
* Installation and configuration of PostgreSQl on ubuntu (https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-22-04-quickstart)
* Installation and configuration of Ansible on Ubuntu (https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-22-04)


3) Using Terraform create an IAM role and attach to the EC2 instances (use any public resources as reference).

4) Ensure you can log into to the instance using SSH keys - (the ssh user is ubuntu)

5) Using the concept of partial configuration initialise the Terraform codebase for the test environment and then provision the test resources.
Example
```
terraform init \
    -backend-config="bucket=technologiesoutcomes-terraform-backend-test"
terraform apply --var-file=./env/test/terraform.tfvars

```

6) Using the concept of partial configuration initialise the Terraform codebase for the prd environment and then provision the prd resources.
Example
```
terraform init \
    -backend-config="bucket=technologiesoutcomes-terraform-backend-prd"
terraform apply --var-file=./env/prd/terraform.tfvars

```

8) Log onto the servers and the  AWS console to perform post-implementation verifications checks.

9) Remember to DESTROY all the resources (using terraform destroy)

References
===========

* https://github.com/terraform-in-action/manning-code.git
* The terraform-in-action book
* Three-tier project
* https://github.com/technologiesoutcomes/simpleterraform
