terraform {
  # source = "../../../../modules//data-stores/mysql"
  source = "github.com/LovingFox/terraform-up-and-running-code//code/terraform/08-terraform-team/modules/data-stores/mysql?ref=v0.0.9"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  db_name     = "example_stage"
  db_username = "admin"

  # Set the password using the TF_VAR_db_password environment variable
}
