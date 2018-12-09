## Description

Repository comprises of following Terraform modules

* ca: It creates Certificate Authority (CA) public key/certificate.
* certificate: It creates private key (pem) and public key of TLS certificate signed by above generate CA.

## Steps

* Generate the CA and TLS certificates as per [example](./example/main.tf).
* Import the CA in the Browser.
* Import the TLS certificates in your application/web servers.



