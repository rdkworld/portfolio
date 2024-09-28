module "bastion_host" {
  source = "./modules/bastion_host"
  project             = var.project
  region              = var.region
  vpc_id              = var.vpc_id
  public_subnet_a_id  = var.public_subnet_a_id
  public_subnet_b_id  = var.public_subnet_b_id
  private_subnet_a_id = var.public_subnet_a_id
  private_subnet_b_id = var.public_subnet_b_id
  db_master_username  = var.db_master_username
}