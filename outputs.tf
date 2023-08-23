output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

 output "target_group_arn" {
  description = "Target group arn"
  value = module.nlb.target_group_arns
 }
output "lb-security_group_id" {
  description = "Load balancer security group id"
  value = aws_security_group.quotegen-app-nlb-sg.id
}

output "default_security_group_id" {
  description = "Default security group id"
  value = module.vpc.default_security_group_id
}