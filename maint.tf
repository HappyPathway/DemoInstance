//--------------------------------------------------------------------
// Workspace Data
data "terraform_remote_state" "awsdemo_darnold_tfe_network" {
  backend = "atlas"
  config {
    name    = "AWSDemoDarnoldTFE/Network"
  }
}

//--------------------------------------------------------------------
// Modules
module "ec2_instance" {
  source  = "app.terraform.io/AWSDemoDarnoldTFE/ec2-instance/aws"
  version = "4.0.0"

  instance_name = "DemoInstance"
  instance_type = "m4.large"
  key_name = "tfe-demos-darnold"
  subnet_id = "${element(data.terraform_remote_state.awsdemo_darnold_tfe_network.public_subnets, 0)}"
}
