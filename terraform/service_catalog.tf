# learn-terraform-aft-global-customizations/terraform/service_catalog.tf
locals {
  aft_management_account_id = "022748072614"  # Asegúrate de que este ID es correcto
}

resource "aws_servicecatalog_principal_portfolio_association" "learn_aft" {
  portfolio_id  = "port-pfvpa5vdm5gxk"  # ID de tu portafolio nuevo
  principal_arn = "arn:aws:iam::${local.aft_management_account_id}:role/AWSControlTowerExecution"
}