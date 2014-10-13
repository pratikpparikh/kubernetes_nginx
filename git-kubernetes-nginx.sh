#!/bin/bash
git clone https://github.com/doublerr/kubernetes_nginx /opt/kubernetes_nginx
docker build -t kubernetes_nginx:latest /opt/kubernetes_nginx