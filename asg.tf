module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.10.0"
  
  depends_on = [ module.nlb.target_group_arns ]

  name = "quotegen-asg"
  min_size                  = 1
  max_size                  = 8
  desired_capacity          = 4

  launch_template_name        = "quotegen-asg-launch-template"
  launch_template_description = "Launch template for quotegen app"
  update_default_version      = true

  image_id          = "ami-053b0d53c279acc90"
  instance_type     = "t3.nano"
  instance_name = "quotegen-server"
  ebs_optimized     = true
  enable_monitoring = true
  key_name = "quotegen-key"

  security_groups = [module.vpc.default_security_group_id]

  target_group_arns = [data.aws_lb_target_group.quotegen.arn]

  vpc_zone_identifier = module.vpc.public_subnets

  user_data = base64encode(<<EOT
#!/bin/bash
apt update -y 
apt install docker.io -y
docker login -u tenongene -p dckr_pat_S9uB8skK2kSluGbxuqJVYl1VmLs 
docker run -d --name quotegen -p 7272:7272 tenongene/quotegen:latest
EOT
  )
  health_check_type = "ELB"
}

