module "ca" {
  source             = "../modules/ca"
  ca_common_name     = "${var.common_name}"
  organization_name  = "${var.organization_name}"
  ca_public_key_path = "ca.crt"
}

module "api-cert" {
  source                = "../modules/certificate"
  common_name           = "${var.common_name}"
  organization_name     = "${var.organization_name}"
  cert_private_key_path = "api.anveshak.in.pem"
  dns_names             = ["api.anveshak.in"]
  ca_key_algorithm      = "${module.ca.ca_key_algorithm}"
  ca_private_key_pem    = "${module.ca.ca_private_key_pem}"
  ca_cert_pem           = "${module.ca.ca_cert_pem}"
  cert_public_key_path  = "api.anveshak.in.crt"
}

module "frontend-cert" {
  source                = "../modules/certificate"
  common_name           = "${var.common_name}"
  organization_name     = "${var.organization_name}"
  cert_private_key_path = "www.anveshak.in.pem"
  dns_names             = ["www.anveshak.in"]
  ca_key_algorithm      = "${module.ca.ca_key_algorithm}"
  ca_private_key_pem    = "${module.ca.ca_private_key_pem}"
  ca_cert_pem           = "${module.ca.ca_cert_pem}"
  cert_public_key_path  = "www.anveshak.in.crt"
}
