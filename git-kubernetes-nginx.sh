#!/bin/bash

IFACE=${1:-eth0}

IP=`ifconfig $IFACE | grep -m 1 inet | awk '{print $2}'`
/usr/bin/cp /opt/.kubernetes_auth /opt/kubernetes_nginx/.kubernetes_auth

cat << EOF > /opt/kubernetes_nginx/kub-ssl.cnf
[ req ]
distinguished_name     = req_distinguished_name

[ req_distinguished_name ]
O = Kubernetes
CN = kubernetes.invalid

[ v3_ca ]
subjectAltName = IP:$IP
EOF

docker build -t kubernetes_nginx:latest /opt/kubernetes_nginx
