# gitawsdemo
Terraform, Gitlab, and AWS
    
Creation of a terraform module template that provisions:
	

		
1.  VPC with CIDR 10.0.0.0/16
		2 subnets (public) with CIDR 10.0.1.0/24 and 10.0.2.0/24
		An autoscaling group with Amazon Linux 2 instance (t3.nano) with a min of 2 instances and max of 3
		Create a bucket to store your terraform state
	
	

2.  Use Gitlab to create a CI/CD pipeline that will test the and deploy the infrastructure through AWS

