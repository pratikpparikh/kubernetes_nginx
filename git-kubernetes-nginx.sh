#!/bin/bash
IP=`ip addr show eth0|awk '/inet / {print $2}'|cut -f1 -d/`
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
