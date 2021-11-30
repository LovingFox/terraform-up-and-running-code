terraform {
  # source = "../../../../modules//services/hello-world-app"
  source = "github.com/LovingFox/terraform-up-and-running-code//code/terraform/08-terraform-team/modules/services/hello-world-app?ref=v0.0.8"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../../data-stores/mysql"]
}

inputs = {
  environment = "stage"

  min_size = 2
  max_size = 2

  enable_autoscaling = false

  db_remote_state_bucket = get_env("TEST_STATE_S3_BUCKET", "")
  db_remote_state_key    = "data-stores/mysql/terraform.tfstate"

}
