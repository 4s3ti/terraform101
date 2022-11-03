remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket   = "${local.state_bucket}"
    key      = "tf101/06-terragrunt/dev/${path_relative_to_include()}/terraform.tfstate"
    region   = "eu-west-1"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
}
EOF
}

locals {
  region = "eu-north-1"
  state_bucket = "MyS3Bucket"
}

inputs = {
  region            = local.region
  availability_zone = "${local.region}a"

  tags = {
    Name        = "tf101"
    environment = "dev"
  }

  instance_type = "t3.micro"
  ami           = "ami-051a4a0c60c88f085"
  key_name      = "MySSHKey"
}
