resource "tls_private_key" "cert" {
  algorithm   = "${var.private_key_algorithm}"
  ecdsa_curve = "${var.private_key_ecdsa_curve}"
  rsa_bits    = "${var.private_key_rsa_bits}"
}

resource "local_file" "cert_file" {
  content  = "${tls_private_key.cert.private_key_pem}"
  filename = "${var.cert_private_key_path}"
}

resource "tls_cert_request" "cert" {
  key_algorithm   = "${tls_private_key.cert.algorithm}"
  private_key_pem = "${tls_private_key.cert.private_key_pem}"

  dns_names    = ["${var.dns_names}"]
  ip_addresses = ["${var.ip_addresses}"]

  subject {
    common_name  = "${var.common_name}"
    organization = "${var.organization_name}"
  }
}

resource "tls_locally_signed_cert" "cert" {
  cert_request_pem = "${tls_cert_request.cert.cert_request_pem}"

  ca_key_algorithm   = "${var.ca_key_algorithm}"
  ca_private_key_pem = "${var.ca_private_key_pem}"
  ca_cert_pem        = "${var.ca_cert_pem}"

  validity_period_hours = "${var.validity_period_hours}"
  allowed_uses          = ["${var.allowed_uses}"]
}

resource "local_file" "cert_public_key" {
  content  = "${tls_locally_signed_cert.cert.cert_pem}"
  filename = "${var.cert_public_key_path}"
}
