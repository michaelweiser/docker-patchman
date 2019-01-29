#!/bin/sh

rm -f index.txt serial
touch index.txt
echo 0000 > serial

openssl genrsa -out private/cakey.pem 4096
openssl req -config openssl.cnf -new -x509 -key private/cakey.pem -out cacert.pem -days 3650 -subj /CN=CA

openssl genrsa -out private/nginx.pem 2048
openssl req -config openssl.cnf -new -key private/nginx.pem -out private/nginx.csr -subj /CN=patchman-docker.example.com
openssl ca -config openssl.cnf -batch -in private/nginx.csr -out certs/nginx.pem -policy policy_anything

openssl genrsa -out private/client.pem 2048
openssl req -config openssl.cnf -new -key private/client.pem -out private/client.csr -subj /CN=client
openssl ca -config openssl.cnf -batch -in private/client.csr -out certs/client.pem -policy policy_anything
openssl pkcs12 -export -out client.p12 -in certs/client.pem -inkey private/client.pem -password pass:
