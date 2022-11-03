include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../04-Modules/modules/vpc"
}
