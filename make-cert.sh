#!/bin/bash

# Copyright 2014 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
  -subj "/O=Kubernetes" \
  -keyout /usr/share/nginx/rootCA.key  -out /usr/share/nginx/rootCA.crt

openssl genrsa -out /tmp/server.key 2048
openssl rsa -in /tmp/server.key -out /usr/share/nginx/server.key

openssl req -new -key /usr/share/nginx/server.key -out /tmp/host.csr \
  -config /root/kub-ssl.cnf -extensions v3_ca \
  -subj "/CN=kubernetes.invalid/O=Kubernetes" 

openssl x509 -req -in /tmp/host.csr -CA /usr/share/nginx/rootCA.crt \
  -extfile /root/kub-ssl.cnf -extensions v3_ca \
  -CAkey /usr/share/nginx/rootCA.key \
  -CAcreateserial -out /usr/share/nginx/server.crt -days 365


cat /usr/share/nginx/server.crt /usr/share/nginx/rootCA.crt > /usr/share/nginx/server.cert
