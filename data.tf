data "aws_lb_target_group" "quotegen" {
  arn = "${module.nlb.target_group_arns[0]}"
}

# data "aws_security_group" "quotgen-sg_id" {
#   id = module.nlb.security_group_id
# }