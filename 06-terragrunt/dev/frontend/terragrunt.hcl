include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

terraform {
  source = "../../../04-Modules/modules/ec2"
}

inputs = {
  instance_count = 2
  vpc_id         = dependency.vpc.outputs.vpc_id
  subnet_id      = dependency.vpc.outputs.subnet_id
}
